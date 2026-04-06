import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'dart:async'; 
import 'package:flutter11th/landing_page.dart';


/* import 'allied_service_division_view.dart';
import 'list_of_offices_view.dart';
import 'medical_service_division_view.dart';
import 'nursing_service_division_view.dart';
import 'allied_service_division_view.dart'; */


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

  String searchQuery = "";


  //timer for screen inactivty
  Timer? _inactivityTimer; 
        Timer? _warningTimer;       //  the 10s countdown alert

  bool _alertVisible = false; 
  int _countdown = 10;       
  Timer? _countdownTimer;  

  // Map each service to its PDF file
  late Map<String, String> servicePdfMap;


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
      'Access to Closed Circuit Television Image/Footage': 'assets/BRGHGMC/Host/External/Access to Closed Circuit Television Image_Footage.pdf',
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

      //hidden category from different views
      //-------NSD INTERNAL SERVICES-------
      'Management of Patient for Surgery': 'assets/BRGHGMC/NSD/Internal/Management of Patient for Surgery.pdf',
      'Admission and Discharge': 'assets/BRGHGMC/NSD/Internal/Admission and Discharge.pdf',
      'Dispensing of Medical Supplies in Clinical Areas and Sections of the Hospital': 'assets/BRGHGMC/NSD/Internal/Dispensing of Medical Supplies in Clinical Areas and Sections of the Hospital.pdf',
      'Sterilization of Medical Supplies and Surgical Instruments': 'assets/BRGHGMC/NSD/Internal/Sterilization of Medical Supplies and Surgical Instruments.pdf',

      //-------NSD EXTERNAL SERVICES-------
      'Admission from Emergency Department to Clinical Wards': 'assets/BRGHGMC/NSD/External/Admission from Emergency Department to Clinical Wards.pdf',
      'Admission of Patients to the Acute Care for the Elderly Unit': 'assets/BRGHGMC/NSD/External/Admission of Patients to the Acute Care for the Elderly Unit.pdf',
      'Admission of Patients to the Clinical Nursing Units': 'assets/BRGHGMC/NSD/External/Admission of Patients to the Clinical Nursing Units.pdf',
      'Admission of Patients to the Neonatal Intensive Care Unit': 'assets/BRGHGMC/NSD/External/Admission of Patients to the Neonatal Intensive Care Unit.pdf',
      'Automated Peritoneal Dialysis Treatment to All PD Patient': 'assets/BRGHGMC/NSD/External/Automated Peritoneal Dialysis Treatment to All PD Patient.pdf',
      'Discharge of Patients at the Clinical Nursing Units': 'assets/BRGHGMC/NSD/External/Discharge of Patients at the Clinical Nursing Units.pdf',
      'Dispensing of Medical Supplies for Admitted Patients': 'assets/BRGHGMC/NSD/External/Dispensing of Medical Supplies for Admitted Patients.pdf',
      'Dispensing of Medical Supplies for Out-Patients': 'assets/BRGHGMC/NSD/External/Dispensing of Medical Supplies for Out-Patients.pdf',
      'Ears, Nose, Throat (ENT) Department Registration and Consultation': 'assets/BRGHGMC/NSD/External/Ears, Nose, Throat (ENT) Department Registration and Consultation.pdf',
      'Geriatric OPD Patients': 'assets/BRGHGMC/NSD/External/Geriatric OPD Patients.pdf',
      'Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients': 'assets/BRGHGMC/NSD/External/Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients.pdf',
      'Human Immunodeficiency Virus (HIV) Counseling and Testing Services': 'assets/BRGHGMC/NSD/External/Human Immunodeficiency Virus (HIV) Counseling and Testing Services.pdf',
      'Issuance of Hemodialysis Documents': 'assets/BRGHGMC/NSD/External/Issuance of Hemodialysis Documents.pdf',
      'Management of Patient at the Emergency Department': 'assets/BRGHGMC/NSD/External/Management of Patient at the Emergency Department.pdf',
      'National Tuberculosis Program (NTP) Integrated Delivery of TB Services': 'assets/BRGHGMC/NSD/External/National Tuberculosis Program (NTP) Integrated Delivery of TB Services.pdf',
      'Ophthalmology Department Eye Surgery and Laser Procedure': 'assets/BRGHGMC/NSD/External/Ophthalmology Department Eye Surgery and Laser Procedure.pdf',
      'Out-Patient Department Patients Registration and Consultation': 'assets/BRGHGMC/NSD/External/Out-Patient Department Patients Registration and Consultation.pdf',
      'Peritoneal Dialysis Exit Site Care and Change of Extension Catheter': 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Exit Site Care and Change of Extension Catheter.pdf',
      'Peritoneal Dialysis Patients Registration and Consultation': 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Patients Registration and Consultation.pdf',
      'Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients': 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients.pdf',

      
      //-------MCCO EXTERNAL---------
      'Handling Resolution of Complaints filed with the PACD, 8888, PCC, and CCB and direct filing with the legal unit': 'assets/BRGHGMC/MCCO/External/medical.pdf',

      //-------one pdf only
      'Internal Medical Service': 'assets/pdfs/InternalMedicalService.pdf',
      'List of Offices': 'assets/pdfs/ListOffice.pdf',
      'Mechanism': 'assets/pdfs/Mechanism.pdf',


      //-------MSD EXTERNAL---------
      'Dental Consultation and Treatment': 'assets/BRGHGMC/MSD/External/Dental Consultation and Treatment.pdf',
      'Outpatient Physical Therapy Treatment': 'assets/BRGHGMC/MSD/External/Outpatient Physical Therapy Treatment.pdf',
      'Processing of Request for 24-hour Ambulatory Blood Pressure Monitorin(APBM) and 24-hour Holter Examination': 'assets/BRGHGMC/MSD/External/APBM.pdf',
      'Processing of Requests X-Ray, Ultrasound, and Computerized': 'assets/BRGHGMC/MSD/External/Processing of Requests X-Ray, Ultrasound, and Computerized.pdf',
      'Processing of Request for Two-Dimensional Echocardiography with Doppler Studies': 'assets/BRGHGMC/MSD/External/Processing of Request for Two-Dimensional Echocardiography with Doppler Studies.pdf',
      'Provision of Laboratory Services for In-Patients': 'assets/BRGHGMC/MSD/External/Provision of Laboratory Services for In-Patients.pdf',
      'Provision of Laboratory Services for Out-Patients': 'assets/BRGHGMC/MSD/External/outp.pdf',
      'Provision of Satellite Laboratory Servies': 'assets/BRGHGMC/MSD/External/Provision of Satellite Laboratory Servies.pdf',

      //------MSD INTERNAL---------
      'Special Function Meal Request': 'assets/BRGHGMC/MSD/External/Special Function Meal Request.pdf',

      //------ASD EXTERNAL---------
      'Classification of Admitted Patients (MSS Inpatient)': 'assets/BRGHGMC/ASD/External/Classification of Admitted Patients (MSS Inpatient).pdf',
      'Dispensing of Drugs and Medicines for In-Patients': 'assets/BRGHGMC/ASD/External/Dispensing of Drugs and Medicines for In-Patients.pdf',
      'Dispensing of Drugs and Medicines for Out-Patients': 'assets/BRGHGMC/ASD/External/Dispensing of Drugs and Medicines for Out-Patients.pdf',
      'Enrollment to Point of Service Program': 'assets/BRGHGMC/ASD/External/Enrollment to Point of Service Program.pdf',
      'Issuance of Death & Medical Certificate, Medical Abstract and Certificate of Confinement': 'assets/BRGHGMC/ASD/External/Issuance of Death & Medical Certificate, Medical Abstract and Certificate of Confinement.pdf',
      'Issuance of Medical Certificate or Medical Abstract': 'assets/BRGHGMC/ASD/External/Issuance of Medical Certificate or Medical Abstract.pdf',
      'Issuance of Registered Birth Certificate': 'assets/BRGHGMC/ASD/External/Issuance of Registered Birth Certificate.pdf',
      'Medication Counseling for OPD Geriatric Patientspdf': 'assets/BRGHGMC/ASD/External/Medication Counseling for OPD Geriatric Patientspdf.pdf',
      'Nutrition Care Process': 'assets/BRGHGMC/ASD/External/Nutrition Care Process.pdf',
      'Patient Classification (Malasakit Center In–Patient)': 'assets/BRGHGMC/ASD/External/Patient Classification (Malasakit Center In–Patient).pdf',
      'Patient Classification (Malasakit Center Out-Patient)': 'assets/BRGHGMC/ASD/External/Patient Classification (Malasakit Center Out-Patient).pdf',
      'Patient Classification MSS - Emergency Room': 'assets/BRGHGMC/ASD/External/Patient Classification MSS - Emergency Room.pdf',
      'Tube Feeding Instruction to Patients Watcher_Patient': 'assets/BRGHGMC/ASD/External/Tube Feeding Instruction to Patients Watcher_Patient.pdf',
    };
  }

  List<String> get services {
    final type = widget.serviceType ?? 'External Services';
    List<String> baseList; 


    if (type == 'Internal Services') {
      baseList = widget.internalButtonNames ?? 
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
    }else{
      baseList = widget.externalButtonNames ?? 
          const [
        'Access to Closed Circuit Television Image/Footage',
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


  if(searchQuery.isEmpty) return baseList; 
  // Search across all available services (including hidden ones) for matching results
  return servicePdfMap.keys
     .where((service)=>
     service.toLowerCase().contains(searchQuery))
     .toList();
}

   void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _warningTimer?.cancel();

    _warningTimer = Timer(const Duration(seconds: 10), _showCountdownAlert);

    _inactivityTimer = Timer(const Duration(seconds: 20), _returnToLanding);
  }



    
 void _resetInactivityTimer() {
    _dismissAlert();        // hide alert if visible
    _startInactivityTimer(); // restart both timers 
  }


  void _returnToLanding() {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LandingPage()), // amo nadi screen timeout
        (route) => false,
      );
    }
  }

  void _showCountdownAlert() {
    if (!mounted) return;
    setState(() {
      _alertVisible = true;
      _countdown = 10;
    });

    //  every second from 10 down to 0
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) { timer.cancel(); return; }
      setState(() => _countdown--);
// alert count
      if (_countdown <= 0) {
        timer.cancel();
        setState(() => _alertVisible = false);
      }
    });
  }

  void _dismissAlert() {
    _countdownTimer?.cancel();
    setState(() {
      _alertVisible = false;
      _countdown = 10;
    });
  }


  @override
  void initState() {
    super.initState();
    _startInactivityTimer(); // amo nadi screen timeout
        servicePdfMap = _buildServicePdfMap();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel(); // amo nadi screen timeout
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _resetInactivityTimer,
      onPanDown: (_) => _resetInactivityTimer(),
      // alert top
      child: Stack(
        children: [
          _buildContent(context),

          // amo di count down float
          if (_alertVisible)
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // countdown number big and bold
                      Text(
                        '$_countdown',
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Alert',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Returning to landing page due to inactivity.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _dismissAlert,
                          child: const Text('Dismiss', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    if (opened == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'Hospital Operations and Patient Support Service Division',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${widget.serviceType ?? 'External Services'}',
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
                      const Text('No PD.', style: TextStyle(fontSize: 14)),
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
                setState(() {
                  searchQuery = value.toLowerCase();
                });
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

