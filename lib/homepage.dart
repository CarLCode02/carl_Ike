import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfrx/pdfrx.dart';

import 'category_views/allied_service_division_view.dart';
import 'category_views/feedback_complaints_view.dart';
import 'category_views/hospital_operations_support_view.dart';
import 'category_views/list_of_offices_view.dart';
import 'category_views/medical_center_chief_office_view.dart';
import 'category_views/medical_service_division_view.dart';
import 'category_views/nursing_service_division_view.dart';

const String logoUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkIw4OWQiV_yA9bzadlniIC80ObGNLwx97bg&s';

// all services with their pdf paths, category, and service type
const List<Map<String, String>> _allServices = [
  // MCCO External
  {'name': 'Handling and Resolution of Complaints filed with the PACD, 8888, PCC,and CCB and direct filing with the legal unit',
   'category': 'chief', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/MCCO/External/medical.pdf'
   },

  // MSD External
  {'name': 'Dental Consultation and Treatment',
   'category': 'medical', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/MSD/External/Dental Consultation and Treatment.pdf'
   },
  {'name': 'Outpatient Physical Therapy Treatment', 
  'category': 'medical', 
  'serviceType': 'External Services',
   'pdf': 'assets/BRGHGMC/MSD/External/Outpatient Physical Therapy Treatment.pdf'
   },
  {'name': 'Processing of Request for 24-hour Ambulatory Blood Pressure Monitoring(ABPM) and 24-hour Holter Examinations',
   'category': 'medical', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/MSD/External/ABPM.pdf'
    },
  {'name': 'Processing of Requests X-Ray, UItrasound, and Computerized Tompgraphy Scan',
   'category': 'medical', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/MSD/External/Processing of Requests X-Ray, Ultrasound, and Computerized.pdf'
    },
  {'name': 'Processing of Request for Two-Dimensional Echocardiography with Doppler Studies',
   'category': 'medical',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/MSD/External/Processing of Request for Two-Dimensional Echocardiography with Doppler Studies.pdf'
     },
  {'name': 'Provision of Laboratory Services for In-Patients',
   'category': 'medical', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/MSD/External/Provision of Laboratory Services for In-Patients.pdf'
    },
  {'name': 'Provision of Laboratory Services for Out-Patients',
   'category': 'medical', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/MSD/External/Provision of Laboratory Services for Out-Patients.pdf'
   },
  {'name': 'Provision of Satellite Laboratory Servies', 
  'category': 'medical',
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/MSD/External/Provision of Satellite Laboratory Servies.pdf'
    },
  // MSD Internal
  {'name': 'Special Function Meal Request',
   'category': 'medical', 
   'serviceType': 'Internal Services',
    'pdf': 'assets/BRGHGMC/MSD/Internal/Special Function Meal Request.pdf'
    },

  // NSD External
  {'name': 'Admission from Emergency Department to Clinical Wards',
   'category': 'nursing', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/NSD/External/Admission from Emergency Department to Clinical Wards.pdf'
   },
  {'name': 'Admission of Patients to the Acute Care for the Elderly Unit',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Admission of Patients to the Acute Care for the Elderly Unit.pdf'
     },
  {'name': 'Admission of Patients to the Clinical Nursing Units',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Admission of Patients to the Clinical Nursing Units.pdf'
     },
  {'name': 'Admission of Patients to the Neonatal Intensive Care Unit',
   'category': 'nursing', 
   'serviceType': 'External Services'
   , 'pdf': 'assets/BRGHGMC/NSD/External/Admission of Patients to the Neonatal Intensive Care Unit.pdf'
   },
  {'name': 'Automated Peritoneal Dialysis Treatment to All PD Patient',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Automated Peritoneal Dialysis Treatment to All PD Patient.pdf'
     },
  {'name': 'Discharge of Patients at the Clinical Nursing Units',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Discharge of Patients at the Clinical Nursing Units.pdf'
     },
  {'name': 'Dispensing of Medical Supplies for Admitted Patients',
   'category': 'nursing', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/NSD/External/Dispensing of Medical Supplies for Admitted Patients.pdf'},
  {'name': 'Dispensing of Medical Supplies for Out-Patients',
   'category': 'nursing', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/NSD/External/Dispensing of Medical Supplies for Out-Patients.pdf'
    },
  {'name': 'Ears, Nose, Throat (ENT) Department Registration and Consultation',
   'category': 'nursing', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/NSD/External/Ears, Nose, Throat (ENT) Department Registration and Consultation.pdf'
   },
  {'name': 'Geriatric OPD Patients Registration and Consultation',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Geriatric OPD Patients.pdf'
     },
  {'name': 'Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients',
   'category': 'nursing', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/NSD/External/Hemodialysis Treatment for Admitted and Enrolled Hemodialysis Patients.pdf'
    },
  {'name': 'Human Immunodeficiency Virus (HIV) Counseling and Testing Services',
   'category': 'nursing',
    'serviceType': 'External Services', 
    'pdf': 'assets/BRGHGMC/NSD/External/Human Immunodeficiency Virus (HIV) Counseling and Testing Services.pdf'
    },
  {'name': 'Issuance of Hemodialysis Documents',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Issuance of Hemodialysis Documents.pdf'
     },
  {'name': 'Management of Patient at the Emergency Department',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Management of Patient at the Emergency Department.pdf'
     },
  {'name': 'National Tuberculosis Program (NTP) Integrated Delivery of TB Services',
   'category': 'nursing', 
   'serviceType': 'External Services', 
   'pdf': 'assets/BRGHGMC/NSD/External/National Tuberculosis Program (NTP) Integrated Delivery of TB Services.pdf'
   },
  {'name': 'Ophthalmology Department Eye Surgery and Laser Procedure',
   'category': 'nursing', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/NSD/External/Ophthalmology Department Eye Surgery and Laser Procedure.pdf'
    },
  {'name': 'Out-Patient Department Patients Registration and Consultation',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Out-Patient Department Patients Registration and Consultation.pdf'
     },
  {'name': 'Peritoneal Dialysis Exit Site Care and Change of Extension Catheter',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Exit Site Care and Change of Extension Catheter.pdf'
     },
  {'name': 'Peritoneal Dialysis Patients Registration and Consultation',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Patients Registration and Consultation.pdf'
     },
  {'name': 'Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients',
   'category': 'nursing',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/NSD/External/Peritoneal Dialysis Z Benefit Claim for Enrolled OPD-PD Patients.pdf'
     },
  // NSD Internal
  {'name': 'Admission and Discharge of Patient to Post-Anesthesia Care Unit',
   'category': 'nursing',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/NSD/Internal/Admission and Discharge of Patient to Post-Anesthesia Care Unit.pdf'
     },
  {'name': 'Dispensing of Medical Supplies in Clinical Areas and Sections of the Hospital',
   'category': 'nursing', 
   'serviceType': 'Internal Services',
    'pdf': 'assets/BRGHGMC/NSD/Internal/Dispensing of Medical Supplies in Clinical Areas and Sections of the Hospital.pdf'
    },
  {'name': 'Management of Patient for Surgery', 
  'category': 'nursing',
   'serviceType': 'Internal Services',
    'pdf': 'assets/BRGHGMC/NSD/Internal/Management of Patient for Surgery.pdf'
    },
  {'name': 'Sterilization of Medical Supplies and Surgical Instruments',
   'category': 'nursing',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/NSD/Internal/Sterilization of Medical Supplies and Surgical Instruments.pdf'
     },

  // ASD External
  {'name': 'Classification of Admitted Patients (MSS Inpatient)',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Classification of Admitted Patients (MSS Inpatient).pdf'
     },
  {'name': 'Dispensing of Drugs and Medicines for In-Patients',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Dispensing of Drugs and Medicines for In-Patients.pdf'
     },
  {'name': 'Dispensing of Drugs and Medicines for Out-Patients',
   'category': 'allied', 
   'serviceType': 'External Services',
    'pdf': 'assets/BRGHGMC/ASD/External/Dispensing of Drugs and Medicines for Out-Patients.pdf'
    },
  {'name': 'Enrollment to Point of Service Program',
   'category': 'allied',
    'serviceType': 'External Services', 
    'pdf': 'assets/BRGHGMC/ASD/External/Enrollment to Point of Service Program.pdf'
    },
  {'name': 'Issuance of Death & Medical Certificate, Medical Abstract and Certificate of Confinement',
   'category': 'allied',
    'serviceType': 'External Services', 
    'pdf': 'assets/BRGHGMC/ASD/External/Issuance of Death & Medical Certificate, Medical Abstract and Certificate of Confinement.pdf'
    },
  {'name': 'Issuance of Medical Certificate or Medical Abstract',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Issuance of Medical Certificate or Medical Abstract.pdf'
     },
  {'name': 'Issuance of Registered Birth Certificate',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Issuance of Registered Birth Certificate.pdf'
     },
  {'name': 'Medication Counseling for OPD Geriatric Patients',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Medication Counseling for OPD Geriatric Patientspdf.pdf'
     },
  {'name': 'Nutrition Care Process',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Nutrition Care Process.pdf'
     },
  {'name': 'Patient Classification (Malasakit Center In-Patient)',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Patient Classification (Malasakit Center In–Patient).pdf'
     },
  {'name': 'Patient Classification (Malasakit Center Out-Patient)',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Patient Classification (Malasakit Center Out-Patient).pdf'
     },
  {'name': 'Patient Classification MSS - Emergency Room',
   'category': 'allied',
    'serviceType': 'External Services', 
    'pdf': 'assets/BRGHGMC/ASD/External/Patient Classification MSS - Emergency Room.pdf'
    },
  {'name': 'Tube Feeding Instruction to Patients Watcher/Patient',
   'category': 'allied',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/ASD/External/Tube Feeding Instruction to Patients Watcher_Patient.pdf'
     },

     //Hospital Internal
  {'name': 'Corrective Maintenance of Information and Communication Technology (ICT) Equipment',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Corrective Maintenance of Information and Communication Technology (ICT) Equipment.pdf'
     },

     {'name': 'Internal/Fabrication of Linen',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Fabrication of Linen.pdf'
     },

       {'name': 'Issuance of Clean Linen',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Issuance of Clean Linen.pdf'
     },

     {'name': 'Leave of Absence Application',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Leave of Absence Application.pdf'
     },


     {'name': 'Payment of Infrastructure Projects Billing',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Payment of Infrastructure Projects Billing.pdf'
     },

     {'name': 'Preparation of Payroll for Non-Permanent Employees',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Preparation of Payroll for Non-Permanent Employees.pdf'
     },

     {'name': 'Processing of Obligation Request and Status (ORS)_Budget Utilization Request and Status(BURS)',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Obligation Request and Status (ORS)_Budget Utilization Request and Status(BURS).pdf'
     },

     {'name': 'Processing of Payrolls',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Payrolls.pdf'
     },

     {'name': 'Processing of Purchase Orders (Bidding)',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Purchase Orders (Bidding).pdf'
     },


     {'name': 'Processing of Purchase Orders (Simple Value Procurement)',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Purchase Orders (Simple Value Procurement).pdf'
     },

     {'name': 'Processing of Request for Documents_Records of Employees',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Request for Documents_Records of Employees.pdf'
     },

     {'name': 'Processing of Service Request per Project_Activity in the Carpentry Section',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Carpentry Section.pdf'
     },

     {'name': 'Processing of Service Request per Project_Activity in the Electrical Section',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Electrical Section.pdf'
     },

     {'name': 'Processing of Service Request per Project_Activity in the Medical Equipment Maintenance Unit',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Medical Equipment Maintenance Unit.pdf'
     },

     {'name': 'Processing of Service Request per Project_Activity in the Plumbing Section',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Processing of Service Request per Project_Activity in the Plumbing Section.pdf'
     },

     {'name': 'Releasing of Cash Benefits',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Releasing of Cash Benefits.pdf'
     },

     {'name': 'Replacement of Identification Card.',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Replacement of Identification Card..pdf'
     },

     {'name': 'Request for Motor Vehicle for Emergency Referral',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Request for Motor Vehicle for Emergency Referral.pdf'
     },
     {'name': '/Request of Motor Vehicle for Official Business',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal//Request of Motor Vehicle for Official Business.pdf'
     },
     {'name': 'Requisition and Issuance of Supplies, Materials and Equipment',
   'category': 'ops',
    'serviceType': 'Internal Services',
     'pdf': 'assets/BRGHGMC/Host/Internal/Requisition and Issuance of Supplies, Materials and Equipment.pdf'
     },

     // External Service Hospiatal
     {'name': 'Acceptance of Job Application',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Acceptance of Job Application.pdf'
     },
          {'name': 'Access to Closed Circuit Television Image_Footage',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Access to Closed Circuit Television Image_Footage.pdf'
     },
          {'name': 'Issuance of Official Receipt',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Issuance of Official Receipt.pdf'
     },
          {'name': 'PhilHealth Registration and Status Updating',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/PhilHealth Registration and Status Updating.pdf'
     },
          {'name': 'PhilHealth Status Verification',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/PhilHealth Status Verification.pdf'
     },
          {'name': 'Preparation of Order of Payment',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Preparation of Order of Payment.pdf'
     },
          {'name': 'Processing of Disbursement Vouchers',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Processing of Disbursement Vouchers.pdf'
     },
          {'name': 'Processing of In-Patient PhilHealth Claims',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Processing of In-Patient PhilHealth Claims.pdf'
     },
          {'name': 'Processing of Out-Patient PhilHealth Claims',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Processing of Out-Patient PhilHealth Claims.pdf'
     },
          {'name': 'Procurement Procedure for Alternative Mode of Procurement',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/PPA.pdf'
     },
          {'name': 'Procurement Procedure Through Competitive Bidding',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Procurement Procedure Through Competitive Bidding.pdf'
     },
          {'name': 'Purchasing of Bidding Documents Through Manual Payment',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Purchasing of Bidding Documents Through Manual Payment.pdf'
     },
          {'name': 'Purchasing of Bidding Documents Through Online Payment',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Purchasing of Bidding Documents Through Online Payment.pdf'
     },
          {'name': 'Receiving of Deliveries, Supplies, Materials and Equipment',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Receiving of Deliveries, Supplies, Materials and Equipment.pdf'
     },
          {'name': 'Releasing of Checks',
   'category': 'ops',
    'serviceType': 'External Services',
     'pdf': 'assets/BRGHGMC/Host/External/Releasing of Checks.pdf'
     },

          // list of offices
     {'name': 'ListOffice',
   'category': 'offices',
    'serviceType': 'External Services',
     'pdf': 'assets/pdfs/ListOffice.pdf'
     },

     // Feedback
     {'name': 'Feedback and Complaints Mechanism',
   'category': 'feedback',
    'serviceType': 'External Services',
     'pdf': 'assets/pdfs/Mechanism.pdf'
     },
];

// maps category key to display name for search result subtitles
const Map<String, String> _categoryLabels = {
  'chief':   'Medical Center Chief Office',
  'medical': 'Medical Service Division',
  'nursing': 'Nursing Service Division',
  'allied':  'Allied Service Division',
     'ops':   'Hospital Operations and Patient Support Service Division',
  'offices':   'List of Offices',
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String?> _dropdownValues = List.filled(9, null);

  String? _selectedCategoryKey;
  String? _selectedServiceType;

  // stores what the user types in the search bar
  String _searchQuery = '';

  // when not null, directly shows this pdf instead of the category view
  String? _directPdfPath;
  // the title shown in the back header when viewing a direct pdf
  String? _directPdfTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 146, 95),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.green, width: 2.0),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(logoUrl),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'BICOL REGION GENERAL HOSPITAL AND GERIATRIC MEDICAL CENTER',
                style: GoogleFonts.inter(
                  fontSize: 21,
                  color: const Color.fromARGB(255, 0, 128, 0),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Service Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(),
                  _buildDropdown(index: 0, categoryKey: 'chief',
                   hint: 'Medical Center Chief Office',
                    items: const ['External Services'], 
                    valueIds: const ['ext']),
                  const SizedBox(height: 12),
                  _buildDropdown(index: 1, categoryKey: 'medical', 
                  hint: 'Medical Service Division',
                   items: const ['External Services', 'Internal Services'], 
                   valueIds: const ['ext', 'int']),
                  const SizedBox(height: 12),
                  _buildDropdown(index: 2, categoryKey: 'nursing', 
                  hint: 'Nursing Service Division', 
                  items: const ['External Services', 'Internal Services'],
                   valueIds: const ['ext', 'int']),
                  const SizedBox(height: 12),
                  _buildDropdown(index: 3, categoryKey: 'allied', 
                  hint: 'Allied Service Division', items: const ['External Services'], 
                  valueIds: const ['ext']),
                  const SizedBox(height: 12),
                  _buildDropdown(index: 4, categoryKey: 'ops', 
                  hint: 'Hospital Operations and Patient Support Service Division', 
                  items: const ['External Services', 'Internal Services'], 
                  valueIds: const ['ext', 'int']),
                  const SizedBox(height: 12),
                  _buildCategoryButton(label: 'Feedback and Complaints Mechanism', 
                  categoryKey: 'feedback'),
                  const SizedBox(height: 12),
                  _buildCategoryButton(label: 'List of Offices', 
                  categoryKey: 'offices'),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _buildSecondContainerView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondContainerView() {

//amo di
    if (_directPdfPath != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // back button header to go back to search
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: Color.fromARGB(255, 240, 248, 255),
            ),
            child: Row(
              children: [
                // tapping back clears the direct pdf and goes back to welcome screen
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() {
                    _directPdfPath = null;
                    _directPdfTitle = null;
                    _selectedCategoryKey = null;
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
          // pdf viewer
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _pdfPreview(assetPath: _directPdfPath!),
            ),
          ),
        ],
      );
    }

    // no category selected, show welcome screen with global search
    if (_selectedCategoryKey == null) {
      // filter services based on search query
      final results = _searchQuery.isEmpty
          ? <Map<String, String>>[]
          : _allServices.where((s) => s['name']!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

      return Column(
        children: [
          // global search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search all services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
              // saves what user types and rebuilds the results
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // show search results if user typed something
          if (_searchQuery.isNotEmpty)
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('No services found.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final service = results[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                            title: Text(service['name']!, style: const TextStyle(fontSize: 13)),
                            subtitle: Text(
                              '${_categoryLabels[service['category']]} • ${service['serviceType']}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                            // when tapped, set the direct pdf path to open it immediately
                            onTap: () => setState(() {
                              _directPdfPath = service['pdf'];
                              _directPdfTitle = service['name'];
                              _searchQuery = '';
                            }),
                          ),
                        );
                      },
                    ),
            ),

          // show welcome content if nothing typed yet
          if (_searchQuery.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/bg.jpg', height: 200, fit: BoxFit.cover),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -70),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(160),
                        border: Border.all(color: Colors.green, width: 5.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(160),
                        child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHMyvIs_OKj60qVtecCudySQlfVXsjwIrZ8w&s'),
                      ),
                    ),
                  ),
                  Text(
                    "Citizen's Charter",
                    style: GoogleFonts.inter(fontSize: 27, color: const Color.fromARGB(255, 0, 128, 0), fontWeight: FontWeight.w800, height: -2),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    if (_selectedCategoryKey == 'chief') return MedicalCenterChiefOfficeView(serviceType: _selectedServiceType);
    if (_selectedCategoryKey == 'medical') return MedicalServiceDivisionView(serviceType: _selectedServiceType);
    if (_selectedCategoryKey == 'nursing') return NursingServiceDivisionView(serviceType: _selectedServiceType);
    if (_selectedCategoryKey == 'allied') return AlliedServiceDivisionView(serviceType: _selectedServiceType);
    if (_selectedCategoryKey == 'ops') return HospitalOperationsSupportView(serviceType: _selectedServiceType);
    if (_selectedCategoryKey == 'feedback') return const FeedbackComplaintsView();
    if (_selectedCategoryKey == 'offices') return const ListOfOfficesView();

    return const SizedBox();
  }

  // loads and shows the pdf, same as in the category views
  Widget _pdfPreview({required String assetPath}) {
    return FutureBuilder<void>(
      future: rootBundle.load(assetPath).then((_) {}),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('uda pa su pdf sa assets\n$assetPath', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: PdfViewer.asset(assetPath, params: const PdfViewerParams()),
        );
      },
    );
  }

  Widget _buildDropdown({required int index, required String categoryKey, required String hint, required List<String> items, required List<String> valueIds}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: DropdownButton<String>(
        value: _dropdownValues[index],
        hint: Text(hint, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        isExpanded: true,
        isDense: false,
        itemHeight: 60,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
        items: List.generate(items.length, (i) => DropdownMenuItem<String>(value: valueIds[i], child: Text(items[i]))),
        selectedItemBuilder: (context) {
          return List.generate(items.length, (i) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hint, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(items[i], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          });
        },
        onChanged: (value) {
          if (value == null) return;
          final int pos = valueIds.indexOf(value);
          final String displayName = pos >= 0 ? items[pos] : value;
          setState(() {
            _dropdownValues[index] = value;
            _selectedCategoryKey = categoryKey;
            _selectedServiceType = displayName;
            _directPdfPath = null;
          });
        },
      ),
    );
  }

  Widget _buildCategoryButton({required String label, required String categoryKey}) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => setState(() {
        _selectedCategoryKey = categoryKey;
        _selectedServiceType = null;
        _directPdfPath = null;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade300),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
