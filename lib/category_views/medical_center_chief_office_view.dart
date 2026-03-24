// toolboxes needed for ui, asset loading, and pdf viewing
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';

// screen for the Medical Center Chief Office category
class MedicalCenterChiefOfficeView extends StatefulWidget {
  // label shown at the top of the list
  final String? serviceType;
  // optional custom button names for external, if not passed uses the default list below
  final List<String>? buttonNames;
  // optional custom button names for internal services
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
  // tracks which button is tapped, null means no button selected yet
  String? opened;

  // stores what the user types in the search bar
  String _searchQuery = '';

  // string path of assets declared
  static const String _chiefOfficePdf1 = 'assets/BRGHGMC/MCCO/External/medical.pdf';
  // internal services pdf path
  static const String _chiefOfficeInternalPdf1 = 'assets/pdfs/PDF.pdf';

  // list of buttons declared in string for calling
  // if internal services selected, show internal buttons, else show external
  List<String> get services {
    final type = widget.serviceType ?? 'External Services';
    return widget.buttonNames ??
        const [
          'Handling and Resolution of Complaints filed with the PACD, 8888, PCC,and CCB and direct filing with the legal unitf',
          
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
          // shows the service type label
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              widget.serviceType ?? 'External Services',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // category label
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Category: Medical Center Chief Office',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          // calling of the declared buttons in string list by index
          // filters the list based on what the user typed in the search bar
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: services.
                  where((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
                  .map((t) => _serviceButton(title: t))
                  .toList(),
            ),
          ),
        ],
      );
    }

    // stores which button was tapped
    final selected = opened;

    // checks if the tapped button is the first one in the list
    // this is how we know which pdf to show per button
    final isFirstButton = selected == services[0];
    final isSecondButton = services.length > 1 && selected == services[1];
    // checks if currently viewing internal services
    final isInternal = (widget.serviceType ?? '') == 'Internal Services';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // back button header showing the tapped button title
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            // if first button, show its pdf (internal or external), else show placeholder
            child: isFirstButton
                ? _pdfPreview(assetPath: isInternal ? _chiefOfficeInternalPdf1 : _chiefOfficePdf1)
                : isSecondButton
                ? _pdfPreview(assetPath: _chiefOfficePdf1)
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
                      const Text('no pdf imported', style: TextStyle(fontSize: 14)),
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
                const Text(
                  'uda.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'uda parin sa asset su pdf\n$assetPath',
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
          child: PdfViewer.asset(
            assetPath,
            params: const PdfViewerParams(),
          ),
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
              // saves what the user types and rebuilds the list
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
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
            onPressed: () {
              setState(() {
                opened = null;
              });
            },
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
        onPressed: () {
          setState(() {
            opened = title;
          });
        },
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.blue),
            const SizedBox(width: 12),
            // button label
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            // arrow icon on the right
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
