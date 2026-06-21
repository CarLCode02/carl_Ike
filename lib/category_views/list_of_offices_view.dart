import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import '../all_services.dart'; // amo nadi - search uses shared allServices

class ListOfOfficesView extends StatefulWidget {
  final List<String>? buttonNames;
  const ListOfOfficesView({super.key, this.buttonNames});

  @override
  State<ListOfOfficesView> createState() => _ListOfOfficesViewState();
}

class _ListOfOfficesViewState extends State<ListOfOfficesView> {
  String? opened;

  // amo nadi - search query state, same pattern as other category views
  String _searchQuery = '';
  String? _directPdfPath;
  String? _directPdfTitle;

  // amo nadi - PDF controller keeps scroll position stable
  final PdfViewerController _pdfController = PdfViewerController();

  // timers removed - homepage handles screen timeout for all views

  static const String _pdf1 = 'assets/pdfs/ListOffice.pdf';

  List<String> get services {
    return widget.buttonNames ?? const ['View List of Offices'];
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    // show direct pdf from search result
    if (_directPdfPath != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: Color.fromARGB(255, 240, 248, 255),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() {
                    _directPdfPath = null;
                    _directPdfTitle = null;
                  }),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(_directPdfTitle ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(child: Padding(padding: const EdgeInsets.all(16), child: _pdfPreview(assetPath: _directPdfPath!))),
        ],
      );
    }

    if (opened == null) {
      // amo nadi - filter allServices based on search query, same as other views
      final searchResults = _searchQuery.isEmpty
          ? <Map<String, String>>[]
          : allServices.where((s) => s['name']!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchHeader(),
          // amo nadi - show search results when user types
          if (_searchQuery.isNotEmpty)
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text('No services found.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final service = searchResults[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                            title: Text(service['name']!, style: const TextStyle(fontSize: 13)),
                            subtitle: Text('${service['category']} • ${service['serviceType']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                            onTap: () => setState(() {
                              _directPdfPath = service['pdf'];
                              _directPdfTitle = service['name'];
                              _searchQuery = '';
                            }),
                          ),
                        );
                      },
                    ),
            ),
          if (_searchQuery.isEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text('List of Offices', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Service', style: TextStyle(fontSize: 13, color: Colors.grey)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: services.map((t) => _serviceButton(title: t)).toList(),
              ),
            ),
          ],
        ],
      );
    }

    final selected = opened;
    final isFirstButton = selected == services.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isFirstButton
                ? _pdfPreview(assetPath: _pdf1)
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(selected ?? 'View', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text('No PDF yet', style: TextStyle(fontSize: 14)),
                  ]),
          ),
        ),
      ],
    );
  }

  Widget _pdfPreview({required String assetPath}) {
    return FutureBuilder<void>(
      future: rootBundle.load(assetPath).then((_) {}),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) {
          return Center(child: Text('uda pa su file sadto folder asset\n$assetPath', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          // amo nadi - tap-absorber so clicking PDF doesn't reset page
          child: Stack(
            children: [
              PdfViewer.asset(assetPath, controller: _pdfController, params: const PdfViewerParams()),
              GestureDetector(onTap: () {}, behavior: HitTestBehavior.translucent, child: const SizedBox.expand()),
            ],
          ),
        );
      },
    );
  }

  Widget _searchHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        color: Color.fromARGB(255, 240, 248, 255),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(border: InputBorder.none, hintText: 'Search all services...'),
              // amo nadi - saves query and triggers search results
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        color: Color.fromARGB(255, 240, 248, 255),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => opened = null)),
          const SizedBox(width: 4),
          Expanded(child: Text(opened ?? 'View', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _serviceButton({required String title}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.centerLeft,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => setState(() => opened = title),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
