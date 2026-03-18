import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';

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
  String? opened;
// string path of assets decalred
  static const String _pdf1 = 'assets/pdfs/nursing_service_division_1.pdf';
// list of button declared in string for calling
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
      'Geriatric OPD Patient’s Registration and Consultation',
      'Hemodialysis Treatment Fee Processing',
      'Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients',
      'Human Immunodeficiency Virus (HIV) Counseling and Testing Services',
      'Issuance of Hemodialysis Documents',
      'Management of Patient at the Emergency Department',
      'National Tuberculosis Program (NTP) Integrated Delivery of TB Services (IDOTS)',
      'Ophthalmology Department Eye Surgery and Laser Procedure',
      'Opthamology Department Patient’s Registration and Consultation',
      'Out-Patient Department Patient’s Registration and Consultation',
      'Peritoneal Dialysis Exit Site Care and Change of Extension Catheter',
      'Peritoneal Dialysis Patient’s Registration and Consultation',
      'Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients',
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (opened == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              widget.serviceType ?? 'External Services',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Category: Nursing Service Division',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(

            // calling of the declared button in string in list by index
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: services.map((t) => _serviceButton(title: t)).toList(),
            ),
          ),
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
                      const Text('Ulllolll', style: TextStyle(fontSize: 14)),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'uda',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'uda pa su file mo sa assets\n$assetPath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
   // view of pdf preview calling the declared path of  the assets
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
                hintText: 'Search services...',
              ),
              onChanged: (value) {
                setState(() {});
              },
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
            onPressed: () {
              setState(() {
                opened = null;
              });
            },
          ),
          const SizedBox(width: 4),
          Text(
            opened ?? 'View',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
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
            const Icon(Icons.picture_as_pdf, color: Colors.blue),
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

