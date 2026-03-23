import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';

class AlliedServiceDivisionView extends StatefulWidget {
  final String? serviceType;
  final List<String>? buttonNames;
  const AlliedServiceDivisionView({
    super.key,
    required this.serviceType,
    this.buttonNames,
  });

  @override
  State<AlliedServiceDivisionView> createState() =>
      _AlliedServiceDivisionViewState();
}

class _AlliedServiceDivisionViewState extends State<AlliedServiceDivisionView> {
  // tracks which button is tapped, null means no button selected yet
  String? opened;

  // string path of assets declared
  static const String _pdf1  = 'assets/BRGHGMC/ASD/External/Classification of Admitted Patients (MSS Inpatient).pdf';
  static const String _pdf2  = 'assets/BRGHGMC/ASD/External/Dispensing of Drugs and Medicines for In-Patients.pdf';
  static const String _pdf3  = 'assets/BRGHGMC/ASD/External/Dispensing of Drugs and Medicines for Out-Patients.pdf';
  static const String _pdf4  = 'assets/BRGHGMC/ASD/External/Enrollment to Point of Service Program.pdf';
  static const String _pdf5  = 'assets/BRGHGMC/ASD/External/Issuance of Death & Medical Certificate, Medical Abstract and Certificate of Confinement.pdf';
  static const String _pdf6  = 'assets/BRGHGMC/ASD/External/Issuance of Medical Certificate or Medical Abstract.pdf';
  static const String _pdf7  = 'assets/BRGHGMC/ASD/External/Issuance of Registered Birth Certificate.pdf';
  static const String _pdf8  = 'assets/BRGHGMC/ASD/External/Medication Counseling for OPD Geriatric Patientspdf.pdf';
  static const String _pdf9  = 'assets/BRGHGMC/ASD/External/Nutrition Care Process.pdf';
  static const String _pdf10 = 'assets/BRGHGMC/ASD/External/Patient Classification (Malasakit Center In–Patient).pdf';
  static const String _pdf11 = 'assets/BRGHGMC/ASD/External/Patient Classification (Malasakit Center Out-Patient).pdf';
  static const String _pdf12 = 'assets/BRGHGMC/ASD/External/Patient Classification MSS - Emergency Room.pdf';
  static const String _pdf13 = 'assets/BRGHGMC/ASD/External/Tube Feeding Instruction to Patients Watcher_Patient.pdf';

  // list of buttons declared in string for calling
  List<String> get services {
    return widget.buttonNames ??
        const [
          'Classification of Admitted Patients (MSS Inpatient)',
          'Dispensing of Drugs and Medicines for In-Patients',
          'Dispensing of Drugs and Medicines for Out-Patients',
          'Enrollment to Point of Service Program',
          'Issuance of Death & Medical Certificate, Medical Abstract and Certificate of Confinement',
          'Issuance of Medical Certificate or Medical Abstract',
          'Issuance of Registered Birth Certificate',
          'Medication Counseling for OPD Geriatric Patients',
          'Nutrition Care Process',
          'Patient Classification (Malasakit Center In-Patient)',
          'Patient Classification (Malasakit Center Out-Patient)',
          'Patient Classification MSS - Emergency Room',
          'Tube Feeding Instruction to Patients Watcher/Patient',
        ];
  }

  @override
  Widget build(BuildContext context) {
    // if no button tapped yet, show the list of buttons
    if (opened == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // search bar at the top
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
              'Category: Allied Service Division',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          // calling of the declared buttons in string list by index
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: services.map((t) => _serviceButton(title: t)).toList(),
            ),
          ),
        ],
      );
    }

    // stores which button was tapped
    final selected = opened;

    // maps each button index to its pdf path
    final Map<String, String> pdfMap = {
      services[0]:  _pdf1,
      services[1]:  _pdf2,
      services[2]:  _pdf3,
      services[3]:  _pdf4,
      services[4]:  _pdf5,
      services[5]:  _pdf6,
      services[6]:  _pdf7,
      services[7]:  _pdf8,
      services[8]:  _pdf9,
      services[9]:  _pdf10,
      services[10]: _pdf11,
      services[11]: _pdf12,
      services[12]: _pdf13,
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
                hintText: 'Search services...',
              ),
              onChanged: (value) => setState(() {}),
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
            const Icon(Icons.picture_as_pdf, color: Colors.blue),
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
