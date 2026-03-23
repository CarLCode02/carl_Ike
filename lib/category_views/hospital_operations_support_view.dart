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

  // Map each service to its PDF file
  late Map<String, String> servicePdfMap;

  @override
  void initState() {
    super.initState();
    servicePdfMap = _buildServicePdfMap();
  }

  Map<String, String> _buildServicePdfMap() {
    return {
      // Internal Services
      'Corrective Maintenance of Information and Communication Technology(ICT) Equipment': 'assets/BRGHGMC/Host/Internal/Corrective Maintenance of Information and Communication Technology (ICT) Equipment.pdf',
      'Fabrication of Linen': 'assets/BRGHGMC/Host/Internal/Fabrication of Linen.pdf',
      'Issuance of Clean Linen': 'assets/BRGHGMC/Host/Internal/Issuance of Clean Linen.pdf',
      'Leave of Absence Application': 'assets/BRGHGMC/Host/Internal/Leave of Absence Application.pdf',
      'Monitoring of Infrastructure Projects': 'assets/BRGHGMC/Host/Internal/Monitoring of Infrastructure Projects.pdf',
      'Payment of Infrastructure Projects Billing': 'assets/BRGHGMC/Host/Internal/Payment of Infrastructure Projects Billing.pdf',
      'Preparation of Payroll for Non-Permanent Employees': 'assets/BRGHGMC/Host/Internal/Preparation of Payroll for Non-Permanent Employees.pdf',
      'Processing of Obligation Request and Status (ORS)/Budget Utilization Request and Status(BURS)': 'assets/BRGHGMC/Host/Internal/Processing of Obligation Request and Status (ORS)_Budget Utilization Request and Status(BURS).pdf',
      'Processing of Payrolls': 'assets/BRGHGMC/Host/Internal/Processing of Payrolls.pdf',
      'Processing of Purchase Orders (Bidding)': 'assets/BRGHGMC/Host/Internal/Processing of Purchase Orders (Bidding).pdf',
      'Processing of Purchase Orders (Simple Value Procurement': 'assets/BRGHGMC/Host/Internal/Processing of Purchase Orders (Simple Value Procurement).pdf',
      'Processing of Request for Documents/Records of Employees': 'assets/BRGHGMC/Host/Internal/Processing of Request for Documents_Records of Employees.pdf',
      'Processing of Service Request per Project/Activity in the Carpentry Section': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Carpentry Section.pdf',
      'Processing of Service Request per Project/Activity in the Medical Equipment Maintenance Unit': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Medical Equipment Maintenance Unit.pdf',
      'Processing of Service Request per Project/Activity in the Plumbing Section': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Plumbing Section.pdf',
      'Releasing of Cash Benefits': 'assets/BRGHGMC/Host/Internal/Releasing of Cash Benefits.pdf',
      'Replacement of Identification Card': 'assets/BRGHGMC/Host/Internal/Replacement of Identification Card.pdf',
      'Requisition and Issuance of Supplies, Materials and Equipment': 'assets/BRGHGMC/Host/Internal/Requisition and Issuance of Supplies, Materials and Equipment.pdf',
      'Request for Motor Vehicle for Emergency Referral': 'assets/BRGHGMC/Host/Internal/Request for Motor Vehicle for Emergency Referral.pdf',
      'Request of Motor Vehicle for Official Business': 'assets/BRGHGMC/Host/Internal/Request of Motor Vehicle for Official Business.pdf',
      
      // External Services
      'Access to Closed-Circuit Television Image/Footage': 'assets/BRGHGMC/Host/External/Access to Closed Circuit Television Image_Footage.pdf',
      'Acceptance of Job Application': 'assets/BRGHGMC/Host/External/Acceptance of Job Application.pdf',
      'Issuance of Official Receipt': 'assets/BRGHGMC/Host/External/Issuance of Official Receipt.pdf',
      'PhilHealth Registration and Status Updating': 'assets/BRGHGMC/Host/External/PhilHealth Registration and Status Updating.pdf',
      'PhilHealth Status Verification': 'assets/BRGHGMC/Host/External/PhilHealth Status Verification.pdf',
      'Preparation of Order of Payment': 'assets/BRGHGMC/Host/External/Preparation of Order of Payment.pdf',
      'Preparation of Statement of Account': 'assets/BRGHGMC/Host/External/Preparation of Statement of Account.pdf',
      'Processing of Disbursement Vouchers': 'assets/BRGHGMC/Host/External/Processing of Disbursement Vouchers.pdf',
      'Processing of In-Patient PhilHealth Claims': 'assets/BRGHGMC/Host/External/Processing of In-Patient PhilHealth Claims.pdf',
      'Processing of Out-Patient PhilHealth Claims': 'assets/BRGHGMC/Host/External/Processing of Out-Patient PhilHealth Claims.pdf',
      'Procurement Procedure Through Competitive Bidding': 'assets/BRGHGMC/Host/External/Procurement Procedure Through Competitive Bidding.pdf',
      'Procurement Procedure for Alternative Mode of Procurement - Small Value Procurement/Shopping (Walk-in Suppliers)': 'assets/BRGHGMC/Host/External/PPA.pdf',
      'Purchasing of Bidding Documents Through Manual Payment': 'assets/BRGHGMC/Host/External/Purchasing of Bidding Documents Through Manual Payment.pdf',
      'Purchasing of Bidding Documents Through Online Payment': 'assets/BRGHGMC/Host/External/Purchasing of Bidding Documents Through Online Payment.pdf',
      'Receiving of Deliveries, Supplies, Materials and Equipme': 'assets/BRGHGMC/Host/External/Receiving of Deliveries, Supplies, Materials and Equipment.pdf',
      'Releasing of Checks': 'assets/BRGHGMC/Host/External/Releasing of Checks.pdf',
    };
  }

  List<String> get services {
    final type = widget.serviceType ?? 'External Services';
    if (type == 'Internal Services') {
      return widget.internalButtonNames ??
          const [
        'Corrective Maintenance of Information and Communication Technology(ICT) Equipment',
        'Fabrication of Linen',
        'Issuance of Clean Linen',
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
      'Receiving of Deliveries, Supplies, Materials and Equipme',
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: selected != null
                ? _pdfPreview(assetPath: servicePdfMap[selected] ?? 'assets/pdfs/medical.pdf')
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
                      const Text('No PDF.', style: TextStyle(fontSize: 14)),
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

