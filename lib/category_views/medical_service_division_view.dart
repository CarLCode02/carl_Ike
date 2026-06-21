import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import '../all_services.dart';

class MedicalServiceDivisionView extends StatefulWidget {
  final String? serviceType;
  final List<String>? externalButtonNames;
  final List<String>? internalButtonNames;
  const MedicalServiceDivisionView({
    super.key,
    required this.serviceType,
    this.externalButtonNames,
    this.internalButtonNames,
  });

  @override
  State<MedicalServiceDivisionView> createState() =>
      _MedicalServiceDivisionViewState();
}

class _MedicalServiceDivisionViewState extends State<MedicalServiceDivisionView> {
  String? opened;
  String _searchQuery = '';
  String? _directPdfPath; // amo di
  String? _directPdfTitle; // amo di

  // amo nadi - single controller for the PDF viewer, never recreated
  final PdfViewerController _pdfController = PdfViewerController();

  // timers removed - homepage handles inactivity timeout for the whole page

  static const String _pdf1 = 'assets/BRGHGMC/MSD/External/Dental Consultation and Treatment.pdf';
  static const String _pdf2 = 'assets/BRGHGMC/MSD/External/Outpatient Physical Therapy Treatment.pdf';
  static const String _pdf3 = 'assets/BRGHGMC/MSD/External/ABPM.pdf';
  static const String _pdf4 = 'assets/BRGHGMC/MSD/External/Processing of Requests X-Ray, Ultrasound, and Computerized.pdf';
  static const String _pdf5 = 'assets/BRGHGMC/MSD/External/Processing of Request for Two-Dimensional Echocardiography with Doppler Studies.pdf';
  static const String _pdf6 = 'assets/BRGHGMC/MSD/External/Provision of Laboratory Services for In-Patients.pdf';
  static const String _pdf7 = 'assets/BRGHGMC/MSD/External/outp.pdf';
  static const String _pdf8 = 'assets/BRGHGMC/MSD/External/Provision of Satellite Laboratory Servies.pdf';
  static const String _pdf9 = 'assets/BRGHGMC/MSD/Internal/Special Function Meal Request.pdf';

  List<String> get services {
    final type = widget.serviceType ?? 'External Services';
    if (type == 'Internal Services') {
      return widget.internalButtonNames ?? const ['Special Function Meal Request'];
    }
    return widget.externalButtonNames ?? const [
      'Dental Consultation and Treatment',
      'Outpatient Physical Therapy Treatment',
      'Processing of Request for 24-hour Ambulatory Blood Pressure Monitoring(ABPM) and 24-hour Holter Examinations',
      'Processing of Requests X-Ray, UItrasound, and Computerized Tompgraphy Scan',
      'Processing of Request for Two-Dimensional Echocardiography with Doppler Studies',
      'Provision of Laboratory Services for In-Patients',
      'Provision of Laboratory Services for Out-Patients',
      'Provision of Satellite Laboratory Servies',
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => setState(() { _directPdfPath = null; _directPdfTitle = null; }), // amo di
                ),
                const SizedBox(width: 4),
                Expanded(child: Text(_directPdfTitle ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Expanded(child: Padding(padding: const EdgeInsets.all(16), child: _pdfPreview(assetPath: _directPdfPath!))),
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
                            onTap: () => setState(() { // amo di
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
              padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
              child: Text('Medical Service Division', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
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
    final isInternal = (widget.serviceType ?? '') == 'Internal Services';
    final Map<String, String> pdfMap = isInternal
        ? {services[0]: _pdf9}
        : {
            services[0]: _pdf1, services[1]: _pdf2, services[2]: _pdf3,
            services[3]: _pdf4, services[4]: _pdf5, services[5]: _pdf6,
            services[6]: _pdf7, services[7]: _pdf8,
          };

    final pdfPath = pdfMap[selected];
    // amo nadi - NO goToPage here — page reset is handled in _serviceButton onPressed only
    // calling goToPage in build() causes it to fire on every setState (countdown ticks etc.)

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: pdfPath != null
                ? _pdfPreview(assetPath: pdfPath)
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(selected ?? 'View', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text('No Pdf Yet', style: TextStyle(fontSize: 14)),
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
          return Center(child: Text('waley pa sa assets folder su pdf file\n$assetPath', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          // amo nadi - Stack with a transparent tap-absorber on top
          // absorbs tap/click events so PDF doesn't reset, but scroll still works
          child: Stack(
            children: [
              PdfViewer.asset(assetPath, controller: _pdfController, params: const PdfViewerParams()),
              // amo nadi - this layer catches taps and does nothing, preventing page resets
              // it does NOT block scroll because GestureDetector only consumes tap, not drag
              GestureDetector(
                onTap: () {}, // absorb tap silently
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
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), color: Color.fromARGB(255, 240, 248, 255)),
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
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), color: Color.fromARGB(255, 240, 248, 255)),
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
        onPressed: () {
          // amo nadi - goToPage(1) here fires ONCE on tap, not on every rebuild
          // this is the only correct place to reset the PDF page
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
