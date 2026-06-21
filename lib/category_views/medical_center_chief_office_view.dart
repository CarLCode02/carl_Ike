import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import '../all_services.dart';

// screen for the Medical Center Chief Office category
class MedicalCenterChiefOfficeView extends StatefulWidget {
  final String? serviceType;
  final List<String>? buttonNames;
  final List<String>? internalButtonNames;
  const MedicalCenterChiefOfficeView({
    super.key,
    required this.serviceType,
    this.buttonNames,
    this.internalButtonNames,
  });

  @override
  State<MedicalCenterChiefOfficeView> createState() =>
      _MedicalCenterChiefOfficeViewState();
}

class _MedicalCenterChiefOfficeViewState
    extends State<MedicalCenterChiefOfficeView> {
  String? opened;
  String _searchQuery = '';
  String? _directPdfPath; // amo di
  String? _directPdfTitle;

  // Here Here pot A - PDF controller keeps scroll position, no reset on setState
  final PdfViewerController _pdfController = PdfViewerController();

  // Here Here pot A - timers removed, homepage handles screen timeout for all views
  // no duplicate alert will appear

  static const String _chiefOfficePdf1 = 'assets/BRGHGMC/MCCO/External/medical.pdf';
  static const String _chiefOfficeInternalPdf1 = 'assets/pdfs/PDF.pdf';

  List<String> get services {
    return widget.buttonNames ??
        const [
          'Handling and Resolution of Complaints filed with the PACD, 8888, PCC,and CCB and direct filing with the legal unit',
        ];
  }

  @override
  void initState() {
    super.initState();
    // Here Here pot A - no timer started here, homepage owns the inactivity timer
  }

  @override
  void dispose() {
    // Here Here pot A - nothing to cancel, homepage handles timers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Here Here pot A - no Listener or Stack needed, homepage Listener covers this view
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
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
                    _directPdfPath = null; // amo di
                    _directPdfTitle = null; // amo di
                  }),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _directPdfTitle ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _pdfPreview(assetPath: _directPdfPath!),
            ),
          ),
        ],
      );
    }

    if (opened == null) {
      final searchResults = _searchQuery.isEmpty
          ? <Map<String, String>>[]
          : allServices.where((s) => s['name']!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchHeader(),
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
                              _directPdfPath = service['pdf']; // amo di
                              _directPdfTitle = service['name']; // amo di
                              _searchQuery = '';
                            }),
                          ),
                        );
                      },
                    ),
            ),
          if (_searchQuery.isEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
              child: Text('Medical Center Chief Office', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.serviceType ?? 'External Services', style: const TextStyle(fontSize: 13, color: Colors.grey)),
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
    final isFirstButton = selected == services[0];
    final isSecondButton = services.length > 1 && selected == services[1];
    final isInternal = (widget.serviceType ?? '') == 'Internal Services';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isFirstButton
                ? _pdfPreview(assetPath: isInternal ? _chiefOfficeInternalPdf1 : _chiefOfficePdf1)
                : isSecondButton
                    ? _pdfPreview(assetPath: _chiefOfficePdf1)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selected ?? 'View', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          const Text('no pdf imported', style: TextStyle(fontSize: 14)),
                        ],
                      ),
          ),
        ),
      ],
    );
  }

  Widget _pdfPreview({required String assetPath}) {
    return FutureBuilder<void>(
      future: rootBundle.load(assetPath).then((_) {}),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('uda parin sa asset su pdf\n$assetPath', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          // Here Here pot A - Stack with tap-absorber so clicking PDF doesn't reset page
          child: Stack(
            children: [
              PdfViewer.asset(assetPath, controller: _pdfController, params: const PdfViewerParams()),
              // Here Here pot A - absorbs tap silently, scroll still passes through
              GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
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
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => opened = null),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              opened ?? 'View',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
        onPressed: () {
          // Here Here pot A - goToPage only when switching to a different service
          if (opened != title) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _pdfController.goToPage(pageNumber: 1);
            });
          }
          setState(() => opened = title);
        },
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
