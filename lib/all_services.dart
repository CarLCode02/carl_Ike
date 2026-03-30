// amo nadi - shared list of all services across all categories
// used by both the homepage search and the medical service division search
const List<Map<String, String>> allServices = [
// MCCO External
  {'name': 'Handling and Resolution of Complaints filed with the PACD, 8888, PCC,and CCB and direct filing with the legal unitf',
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
