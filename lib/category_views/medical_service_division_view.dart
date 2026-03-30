import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import '../all_services.dart'; // amo nadi - import shared services list
import 'dart:async';
import 'package:flutter11th/landing_page.dart';

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

  // stores what the user types in the search bar
  String _searchQuery = '';

  String? _directPdfPath; // amo di
  String? _directPdfTitle; // amo di

  Timer? _inactivityTimer;
   

  static const String _pdf1 = 'assets/BRGHGMC/MSD/External/Dental Consultation and Treatment.pdf';
  static const String _pdf2 = 'assets/BRGHGMC/MSD/External/Outpatient Physical Therapy Treatment.pdf';
  static const String _pdf3 = 'assets/BRGHGMC/MSD/External/ABPM.pdf';
  static const String _pdf4 = 'assets/BRGHGMC/MSD/External/Processing of Requests X-Ray, Ultrasound, and Computerized.pdf';
  static const String _pdf5 = 'assets/BRGHGMC/MSD/External/Processing of Request for Two-Dimensional Echocardiography with Doppler Studies.pdf';
  static const String _pdf6 = 'assets/BRGHGMC/MSD/External/Provision of Laboratory Services for In-Patients.pdf';
  static const String _pdf7 = 'assets/BRGHGMC/MSD/External/outp.pdf';
  static const String _pdf8 = 'assets/BRGHGMC/MSD/External/Provision of Satellite Laboratory Servies.pdf';
  static const String _pdf9 = 'assets/BRGHGMC/MSD/Internal/Special Function Meal Request.pdf';

// list of button in string declaration
  List<String> get services {
    final type = widget.serviceType ?? 'External Services';
    if (type == 'Internal Services') {
      return widget.internalButtonNames ??
          const [
        'Special Function Meal Request',
       
      ];
    }
    return widget.externalButtonNames ??
        const [
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

    void _startInactivityTimer() {
    _inactivityTimer?.cancel(); // amo nadi screen timeout
    _inactivityTimer = Timer(const Duration(minutes: 1), _returnToLanding); // amo nadi screen timeout
  }


    
  void _resetInactivityTimer() {
    _startInactivityTimer(); // amo nadi screen timeout
  }

  void _returnToLanding() {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LandingPage()), // amo nadi screen timeout
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startInactivityTimer(); // amo nadi screen timeout
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel(); // amo nadi screen timeout
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // amo nadi screen timeout
      onTap: _resetInactivityTimer, // amo nadi screen timeout
      onPanDown: (_) => _resetInactivityTimer(), // amo nadi screen timeout
      child: _buildContent(context),
    );
  }

    Widget _buildContent(BuildContext context) {
     if (_directPdfPath != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // amo di - back button to return to the list
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
                  // amo di - clears direct pdf, goes back to list
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
      // amo di - filter all msd services (external + internal) based on search query
      // amo nadi - now searches ALL services across all categories, not just MSD
      final searchResults = _searchQuery.isEmpty
          ? <Map<String, String>>[]
          : allServices.where((s) => s['name']!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchHeader(),
          // amo di - if user typed something, show search results across all services
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
                            // amo nadi - shows which category and service type it belongs to
                            subtitle: Text('${service['category']} • ${service['serviceType']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                            // amo di - tapping opens the pdf directly
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

          // show normal list when nothing is typed
          if (_searchQuery.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 2),
              child: const Text(
                'Medical Center Chief Office',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.serviceType ?? 'External Services',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
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

    // maps each button to its pdf path
    final Map<String, String> pdfMap = isInternal
        ? {
            services[0]: _pdf9,
          }
        : {
            services[0]: _pdf1,
            services[1]: _pdf2,
            services[2]: _pdf3,
            services[3]: _pdf4,
            services[4]: _pdf5,
            services[5]: _pdf6,
            services[6]: _pdf7,
            services[7]: _pdf8,
          };

    final pdfPath = pdfMap[selected];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: pdfPath != null
                ? _pdfPreview(assetPath: pdfPath)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selected ?? 'View',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('No Pdf Yet', style: TextStyle(fontSize: 14)),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
  // loading the  preview of the text button clicked to pdf viewer 
  Widget _pdfPreview({required String assetPath}) {
    return FutureBuilder<void>(
      future: rootBundle.load(assetPath).then((_) {}),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'uda',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'waley pa sa assets folder su pdf file\n$assetPath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: PdfViewer.asset(
            assetPath,
            params: const PdfViewerParams(),
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
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search all services...', // amo di
              ),
              // amo di - saves what user types and rebuilds results
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ],
      ),
    );
  }
// back button in the view pdf to go back to the list of text button
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
            onPressed: () {
              setState(() {
                opened = null;
              });
            },
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
          setState(() {
            opened = title;
          });
        },
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

