import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';

class HospitalOperationsSupportView extends StatefulWidget {
  final String? serviceType;
  final List<String>? externalButtonNames;
  final List<String>? internalButtonNames;
  const HospitalOperationsSupportView({
    super.key,
    required this.serviceType,
    this.externalButtonNames,
    this.internalButtonNames,
  });

  @override
  State<HospitalOperationsSupportView> createState() =>
      _HospitalOperationsSupportViewState();
}

class _HospitalOperationsSupportViewState
    extends State<HospitalOperationsSupportView> {
  String? opened;

  static const String _pdf1 = 'assets/pdfs/hospital_operations_support_1.pdf';

  List<String> get services {
    final type = widget.serviceType ?? 'Externa Services';
    if (type == 'Internal Services') {
      return widget.internalButtonNames ??
          const [
        'Corrective Maintenance of Information and Communication Technology(ICT) Equipment',
        'Fabrication of Linen',
        'Issuance of Clean Line',
        'Leave of Absence Application',
        'Monitoring of Infrastructure Projects',
        'Payment of Infrastructure Projects Billing',
        'Preparation of Payroll for Non-Permanent Employees',
        'Processing of Obligation Request and Status (ORS)/Budget Utilization Request and Status(BURS)',
        'Processing of Payrolls',
        'Processing of Purchase Orders (Bidding)',
        'Processing of Purchase Orders (Simple Value Procurement',
        'Processing of Request for Documents/Records of Employees',
        'Processing of Service Request per Project/Activity in the Carpentry Section',
        'Processing of Service Request per Project/Activity in the Medical Equipment Maintenance Unit',
        'Processing of Service Request per Project/Activity in the Plumbing Section',
        'Releasing of Cash Benefits',
        'Replacement of Identification Card',
        'Requisition and Issuance of Supplies, Materials and Equipment',
        'Request for Motor Vehicle for Emergency Referral',
        'Request of Motor Vehicle for Official Business',
      ];
    }
    return widget.externalButtonNames ??
        const [
      'Access to Closed–Circuit Television Image/Footage',
      'Acceptance of Job Application',
      'Issuance of Official Receipt',
      'PhilHealth Registration and Status Updating',
      'PhilHealth Status Verification',
      'Preparation of Order of Payment',
      'Preparation of Statement of Account',
      'Processing of Disbursement Vouchers',
      'Processing of In-Patient PhilHealth Claims',
      'Processing of Out-Patient PhilHealth Claims',
      'Procurement Procedure Through Competitive Bidding',
      'Procurement Procedure for Alternative Mode of Procurement - Small Value Procurement/Shopping (Walk-in Suppliers)',
      'Purchasing of Bidding Documents Through Manual Payment',
      'Purchasing of Bidding Documents Through Online Payment',
      'Receiving of Deliveries, Supplies, Materials and Equipment',
      'Releasing of Checks',
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
              'Category: Hospital Operations and Patient Support Service Division',
              style: TextStyle(fontSize: 13, color: Colors.grey),
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
                  'PDF not found in assets yet.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Paste your PDF here and re-run:\n$assetPath',
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

