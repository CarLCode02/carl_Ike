import 'package:flutter/material.dart';

import 'category_views/allied_service_division_view.dart';
import 'category_views/feedback_complaints_view.dart';
import 'category_views/hospital_operations_support_view.dart';
import 'category_views/list_of_offices_view.dart';
import 'category_views/medical_center_chief_office_view.dart';
import 'category_views/medical_service_division_view.dart';
import 'category_views/nursing_service_division_view.dart';

const String logoUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkIw4OWQiV_yA9bzadlniIC80ObGNLwx97bg&s';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String?> _dropdownValues = List.filled(9, null);

  String? _selectedCategoryKey;
  String? _selectedServiceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 221, 221),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(logoUrl),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'BICOL REGION GENERAL HOSPITAL AND GERIATRIC MEDICAL CENTER',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    child: Text(
                      'Service Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  _buildDropdown(
                    index: 0,
                    categoryKey: 'chief',
                    hint: 'Medical Center Chief Office',
                    items: const ['External Services'],
                    valueIds: const ['ext'],
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    index: 1,
                    categoryKey: 'medical',
                    hint: 'Medical Service Division',
                    items: const ['External Services', 'Internal Services'],
                    valueIds: const ['ext', 'int'],
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    index: 2,
                    categoryKey: 'nursing',
                    hint: 'Nursing Service Division',
                    items: const ['External Services', 'Internal Services'],
                    valueIds: const ['ext', 'int'],
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    index: 3,
                    categoryKey: 'allied',
                    hint: 'Allied Service Division',
                    items: const ['External Services'],
                    valueIds: const ['ext'],
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    index: 4,
                    categoryKey: 'ops',
                    hint: 'Hospital Operations and Patient Support Service Division',
                    items: const ['External Services', 'Internal Services'],
                    valueIds: const ['ext', 'int'],
                  ),
                  const SizedBox(height: 12),
                  _buildCategoryButton(
                    label: 'Feedback and Complaints Mechanism',
                    categoryKey: 'feedback',
                  ),
                  const SizedBox(height: 12),
                  _buildCategoryButton(
                    label: 'List of Offices',
                    categoryKey: 'offices',
                  ),
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
    if (_selectedCategoryKey == null) {
      return const Center(
        child: Text(
          'Select a category on the left',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    if (_selectedCategoryKey == 'chief') {
      return MedicalCenterChiefOfficeView(serviceType: _selectedServiceType);
    }
    if (_selectedCategoryKey == 'medical') {
      return MedicalServiceDivisionView(serviceType: _selectedServiceType);
    }
    if (_selectedCategoryKey == 'nursing') {
      return NursingServiceDivisionView(serviceType: _selectedServiceType);
    }
    if (_selectedCategoryKey == 'allied') {
      return AlliedServiceDivisionView(serviceType: _selectedServiceType);
    }
    if (_selectedCategoryKey == 'ops') {
      return HospitalOperationsSupportView(serviceType: _selectedServiceType);
    }
    if (_selectedCategoryKey == 'feedback') {
      return const FeedbackComplaintsView();
    }
    if (_selectedCategoryKey == 'offices') {
      return const ListOfOfficesView();
    }

    return const SizedBox();
  }

  Widget _buildDropdown({
    required int index,
    required String categoryKey,
    required String hint,
    required List<String> items,
    required List<String> valueIds,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: _dropdownValues[index],
        hint: Text(
          hint,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        isExpanded: true,
        isDense: false,
        itemHeight: 60,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
        items: List.generate(items.length, (i) {
          return DropdownMenuItem<String>(
            value: valueIds[i],
            child: Text(items[i]),
          );
        }),
        selectedItemBuilder: (context) {
          return List.generate(items.length, (i) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hint,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    items[i],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
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
          });
        },
      ),
    );
  }

  Widget _buildCategoryButton({
    required String label,
    required String categoryKey,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          _selectedCategoryKey = categoryKey;
          _selectedServiceType = null;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

