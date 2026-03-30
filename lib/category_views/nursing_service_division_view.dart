import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import '../all_services.dart'; 
import 'dart:async';
import 'package:flutter11th/landing_page.dart';

class NursingServiceDivisionView extends StatefulWidget {
  final String? serviceType;
  final List<String>? externalButtonNames;
  final List<String>? internalButtonNames;
  const NursingServiceDivisionView({
    super.key,
    required this.serviceType,
    this.externalButtonNames,
    this.internalButtonNames,
  });

  @override
  State<NursingServiceDivisionView> createState() =>
      _NursingServiceDivisionViewState();
}

class _NursingServiceDivisionViewState extends State<NursingServiceDivisionView> {
  // tracks which button 
  String? opened;
    // stores what the user types in the search bar
  String _searchQuery = '';
    String? _directPdfPath; // amo di
  String? _directPdfTitle; // amo di
    Timer? _inactivityTimer;

  // string path of external assets declared
  static const String _ext1  = 'assets/BRGHGMC/NSD/External/Admission from Emergency Department to Clinical Wards.pdf';
  static const String _ext2  = 'assets/BRGHGMC/NSD/External/Admission of Patients to the Acute Care for the Elderly Unit.pdf';
  static const String _ext3  = 'assets/BRGHGMC/NSD/External/Admission of Patients to the Clinical Nursing Units.pdf';
  static const String _ext4  = 'assets/BRGHGMC/NSD/External/Admission of Patients to the Neonatal Intensive Care Unit.pdf';
  static const String _ext5  = 'assets/BRGHGMC/NSD/External/Automated Peritoneal Dialysis Treatment to All PD Patient.pdf';
  static const String _ext6  = 'assets/BRGHGMC/NSD/External/Discharge of Patients at the Clinical Nursing Units.pdf';
  static const String _ext7  = 'assets/BRGHGMC/NSD/External/Dispensing of Medical Supplies for Admitted Patients.pdf';
  static const String _ext8  = 'assets/BRGHGMC/NSD/External/Dispensing of Medical Supplies for Out-Patients.pdf';
  static const String _ext9  = 'assets/BRGHGMC/NSD/External/Ears, Nose, Throat (ENT) Department Registration and Consultation.pdf';
  static const String _ext10 = 'assets/BRGHGMC/NSD/External/Geriatric OPD Patients.pdf';
  static const String _ext11 = 'assets/BRGHGMC/NSD/External/Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients.pdf';
  static const String _ext12 = 'assets/BRGHGMC/NSD/External/Human Immunodeficiency Virus (HIV) Counseling and Testing Services.pdf';
  static const String _ext13 = 'assets/BRGHGMC/NSD/External/Issuance of Hemodialysis Documents.pdf';
  static const String _ext14 = 'assets/BRGHGMC/NSD/External/Management of Patient at the Emergency Department.pdf';
  static const String _ext15 = 'assets/BRGHGMC/NSD/External/National Tuberculosis Program (NTP) Integrated Delivery of TB Services.pdf';
  static const String _ext16 = 'assets/BRGHGMC/NSD/External/Ophthalmology Department Eye Surgery and Laser Procedure.pdf';
  static const String _ext17 = 'assets/BRGHGMC/NSD/External/Out-Patient Department Patients Registration and Consultation.pdf';
  static const String _ext18 = 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Exit Site Care and Change of Extension Catheter.pdf';
  static const String _ext19 = 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Patients Registration and Consultation.pdf';
  static const String _ext20 = 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients.pdf';

  // string path of internal assets declared
  static const String _int1 = 'assets/BRGHGMC/NSD/Internal/Admission and Discharge of Patient to Post-Anesthesia Care Unit.pdf';
  static const String _int2 = 'assets/BRGHGMC/NSD/Internal/Dispensing of Medical Supplies in Clinical Areas and Sections of the Hospital.pdf';
  static const String _int3 = 'assets/BRGHGMC/NSD/Internal/Management of Patient for Surgery.pdf';
  static const String _int4 = 'assets/BRGHGMC/NSD/Internal/Sterilization of Medical Supplies and Surgical Instruments.pdf';

  // list of buttons declared in string for calling
  // if internal services selected, show internal buttons, else show external
  List<String> get services {
    final type = widget.serviceType ?? 'External Services';
    if (type == 'Internal Services') {
      return widget.internalButtonNames ??
          const [
            'Admission and Discharge of Patient to Post-Anesthesia Care Unit',
            'Dispensing of Medical Supplies in Clinical Areas and Sections of the Hospital',
            'Management of Patient for Surgery',
            'Sterilization of Medical Supplies and Surgical Instruments',
          ];
    }
    return widget.externalButtonNames ??
        const [
          'Admission from Emergency Department to Clinical Wards',
          'Admission of Patients to the Acute Care for the Elderly Unit',
          'Admission of Patients to the Clinical Nursing Units',
          'Admission of Patients to the Neonatal Intensive Care Unit',
          'Automated Peritoneal Dialysis Treatment to All PD Patient',
          'Discharge of Patients at the Clinical Nursing Units',
          'Dispensing of Medical Supplies for Admitted Patients',
          'Dispensing of Medical Supplies for Out-Patients',
          'Ears, Nose, Throat (ENT) Department Registration and Consultation',
          'Geriatric OPD Patients Registration and Consultation',
          'Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients',
          'Human Immunodeficiency Virus (HIV) Counseling and Testing Services',
          'Issuance of Hemodialysis Documents',
          'Management of Patient at the Emergency Department',
          'National Tuberculosis Program (NTP) Integrated Delivery of TB Services',
          'Ophthalmology Department Eye Surgery and Laser Procedure',
          'Out-Patient Department Patients Registration and Consultation',
          'Peritoneal Dialysis Exit Site Care and Change of Extension Catheter',
          'Peritoneal Dialysis Patients Registration and Consultation',
          'Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients',
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

    // stores which button was tapped
    final selected = opened;
    final isInternal = (widget.serviceType ?? '') == 'Internal Services';

    // maps each button to its pdf path based on external or internal
    final Map<String, String> pdfMap = isInternal
        ? {
            services[0]: _int1,
            services[1]: _int2,
            services[2]: _int3,
            services[3]: _int4,
          }
        : {
            services[0]:  _ext1,
            services[1]:  _ext2,
            services[2]:  _ext3,
            services[3]:  _ext4,
            services[4]:  _ext5,
            services[5]:  _ext6,
            services[6]:  _ext7,
            services[7]:  _ext8,
            services[8]:  _ext9,
            services[9]:  _ext10,
            services[10]: _ext11,
            services[11]: _ext12,
            services[12]: _ext13,
            services[13]: _ext14,
            services[14]: _ext15,
            services[15]: _ext16,
            services[16]: _ext17,
            services[17]: _ext18,
            services[18]: _ext19,
            services[19]: _ext20,
          };

    final pdfPath = pdfMap[selected];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // back button header showing the tapped button title
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            // if pdf path found, show pdf viewer, else show placeholder
            child: pdfPath != null
                ? _pdfPreview(assetPath: pdfPath)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selected ?? 'View',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text('No PDF yet', style: TextStyle(fontSize: 14)),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  // loading the preview of the text button clicked to pdf viewer
  Widget _pdfPreview({required String assetPath}) {
    return FutureBuilder<void>(
      // tries to load the pdf from assets
      future: rootBundle.load(assetPath).then((_) {}),
      builder: (context, snapshot) {
        // still loading, show spinner
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        // pdf not found in assets, show error
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('uda', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'uda pa su pdf sa assets\n$assetPath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        // view of pdf preview calling the declared path of the assets
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: PdfViewer.asset(assetPath, params: const PdfViewerParams()),
        );
      },
    );
  }

  // search bar at the top of the list view
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

  // back button in the view to go back to the list of buttons
  Widget _backHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        color: Color.fromARGB(255, 240, 248, 255),
      ),
      child: Row(
        children: [
          // tapping this resets opened to null, goes back to the list
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => opened = null),
          ),
          const SizedBox(width: 4),
          // title of the tapped button, cuts off with ... if too long
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

  // list of text buttons declared in string
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
        // when tapped, sets opened to this button title, switches to detail view
        onPressed: () => setState(() => opened = title),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red),
            const SizedBox(width: 12),
            // button label
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            // arrow icon on the right
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
