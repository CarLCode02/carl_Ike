import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // amo nadi - for offset + rounded dropdown menu
import 'dart:async'; // amo nadi timer - needed for Timer

import 'all_services.dart'; // amo di decalartion of pdf strings
import 'category_views/allied_service_division_view.dart';
import 'category_views/feedback_complaints_view.dart';
import 'category_views/hospital_operations_support_view.dart';
import 'category_views/list_of_offices_view.dart';
import 'category_views/medical_center_chief_office_view.dart';
import 'category_views/medical_service_division_view.dart';
import 'category_views/nursing_service_division_view.dart';
import 'landing_page.dart'; // amo nadi timer - navigate back to landing on timeout

const String logoUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkIw4OWQiV_yA9bzadlniIC80ObGNLwx97bg&s';

// amo di decalartion of pdf strings

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

  // amo nadi screen time out - fires at 50s to show the 10s countdown warning
  Timer? _warningTimer;
  // amo nadi screen time out - fires at 60s to navigate back to landing page
  Timer? _inactivityTimer;
  // amo nadi coundow - ticks every second during the countdown alert
  Timer? _countdownTimer;
  // amo nadi coundow - controls visibility of the countdown alert overlay
  bool _alertVisible = false;
  // amo nadi coundow - current countdown value, 10 down to 0
  int _countdown = 10;

  // amo nadi screen time out - starts both the warning (50s) and inactivity (60s) timers
  void _startInactivityTimer() {
    _warningTimer?.cancel();
    _inactivityTimer?.cancel();
    _warningTimer = Timer(const Duration(seconds: 50), _showCountdownAlert); // amo nadi screen time out
    _inactivityTimer = Timer(const Duration(minutes: 1), _returnToLanding);  // amo nadi screen time out
  }

  // amo nadi screen time out - resets all timers and dismisses alert on any user interaction
  void _resetInactivityTimer() {
    _dismissAlert();
    _startInactivityTimer();
  }

  // amo nadi coundow - shows the 10s countdown alert when 10 seconds remain
  void _showCountdownAlert() {
    if (!mounted) return;
    setState(() {
      _alertVisible = true;  // amo nadi coundow
      _countdown = 10;       // amo nadi coundow
    });
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) { // amo nadi coundow
      if (!mounted) { timer.cancel(); return; }
      setState(() => _countdown--); // amo nadi coundow
      if (_countdown <= 0) {
        timer.cancel();
        setState(() => _alertVisible = false); // amo nadi coundow
      }
    });
  }

  // amo nadi coundow - dismisses the alert and stops the countdown tick
  void _dismissAlert() {
    _countdownTimer?.cancel(); // amo nadi coundow
    setState(() {
      _alertVisible = false; // amo nadi coundow
      _countdown = 10;       // amo nadi coundow
    });
  }

  // amo nadi screen time out - navigates back to landing page when timeout fires
  void _returnToLanding() {
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LandingPage()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _startInactivityTimer(); // amo nadi screen time out - begin tracking inactivity on load
  }

  @override
  void dispose() {
    _warningTimer?.cancel();    // amo nadi screen time out
    _inactivityTimer?.cancel(); // amo nadi screen time out
    _countdownTimer?.cancel();  // amo nadi coundow
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // amo nadi screen time out - any tap or drag resets the inactivity timer
      behavior: HitTestBehavior.translucent,
      onTap: _resetInactivityTimer,
      onPanDown: (_) => _resetInactivityTimer(),
      child: Stack(
        children: [
          _buildScaffold(context),

          // amo nadi coundow - countdown alert overlay, shown when 10s remain
          if (_alertVisible)
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 260,
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
                      // amo nadi coundow - big countdown number
                      Text(
                        '$_countdown',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Returning to Home Screen',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text(
                        'No activity detected.\nTap dismiss to stay.',
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
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          // amo nadi coundow - dismiss resets the full timer
                          onPressed: _resetInactivityTimer,
                          child: const Text('Dismiss',
                              style: TextStyle(color: Colors.white)),
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

  Widget _buildScaffold(BuildContext context) {
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
          : allServices.where((s) => s['name']!.toLowerCase().contains(_searchQuery.toLowerCase())).toList(); // amo di decalartion of pdf strings

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

          if (_searchQuery.isEmpty)
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isLandscape = constraints.maxWidth > constraints.maxHeight;

                  final Widget logoWidget = Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: isLandscape ? 52 : 60,
                      backgroundImage: const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHMyvIs_OKj60qVtecCudySQlfVXsjwIrZ8w&s',
                      ),
                    ),
                  );

                  final Widget titleWidget = Column(
                    crossAxisAlignment: isLandscape
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Citizen's Charter",
                        textAlign: isLandscape ? TextAlign.left : TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isLandscape ? 22 : 26,
                          color: const Color.fromARGB(255, 0, 128, 0),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bicol Region General Hospital\n& Geriatric Medical Center',
                        textAlign: isLandscape ? TextAlign.left : TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isLandscape ? 12 : 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );

                  final Widget bgImage = ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/bg.jpg',

                      width: isLandscape ? null : constraints.maxWidth * 0.85,
                      height: isLandscape ? constraints.maxHeight * 0.55 : 180,
                      fit: BoxFit.cover,
                    ),
                  );

                  if (isLandscape) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // left: background image with logo badged on its right edge
                          Expanded(
                            flex: 5,
                            // Stack lets the logo overlap the image border
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                bgImage,
                                // logo sits on the right edge of the image, vertically centered
                                Positioned(
                                  right: -44, // half of logo diameter to straddle the edge
                                  top: 0,
                                  bottom: 0,
                                  child: Center(child: logoWidget),
                                ),
                              ],
                            ),
                          ),

                          // gap accounts for the logo badge that overlaps into this space
                          const SizedBox(width: 60),

                          // right: title + accent bar, logo is now on the image side
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleWidget,
                                const SizedBox(height: 20),
                                // decorative green accent bar
                                Container(
                                  width: 48,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    //port
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              bgImage,
                              Positioned(
                                bottom: -50,
                                child: logoWidget,
                              ),
                            ],
                          ),
                          const SizedBox(height: 62),
                          titleWidget,
                          const SizedBox(height: 16),
                          Container(
                            width: 48,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
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
    // amo nadi - hover state for this specific dropdown
    return StatefulBuilder(
      builder: (context, setLocal) {
        bool hovered = false;
        return StatefulBuilder(
          builder: (context, setHover) {
            return MouseRegion(
              // amo nadi - light green background on hover
              onEnter: (_) => setHover(() => hovered = true),
              onExit: (_) => setHover(() => hovered = false),
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180), // amo nadi - smooth hover transition
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  // amo nadi - switches to light green on hover, grey otherwise
                  color: hovered ? Colors.green.shade50 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    // amo nadi - border also deepens on hover
                    color: hovered ? Colors.green.shade500 : Colors.green.shade300,
                  ),
                ),
                child: DropdownButton2<String>(
                  value: _dropdownValues[index],
                  hint: Text(hint, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  isExpanded: true,
                  underline: const SizedBox(),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                  ),
                  // amo nadi - push menu below the button so it never covers the category label
                  menuItemStyleData: const MenuItemStyleData(height: 48),
                  dropdownStyleData: DropdownStyleData(
                    // amo nadi - offset pushes the menu fully below the button
                    offset: const Offset(0, -6),
                    // amo nadi - rounded corners on the dropdown menu
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    maxHeight: 200, // amo nadi - cap height so it doesn't overlap too many items
                  ),
                  items: List.generate(
                    items.length,
                    (i) => DropdownMenuItem<String>(value: valueIds[i], child: Text(items[i])),
                  ),
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
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategoryButton({required String label, required String categoryKey}) {
    // amo nadi - hover highlight for category buttons
    return StatefulBuilder(
      builder: (context, setHover) {
        bool hovered = false;
        return MouseRegion(
          // amo nadi - light green on hover
          onEnter: (_) => setHover(() => hovered = true),
          onExit: (_) => setHover(() => hovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => setState(() {
              _selectedCategoryKey = categoryKey;
              _selectedServiceType = null;
              _directPdfPath = null;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180), // amo nadi - smooth hover transition
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                // amo nadi - light green on hover
                color: hovered ? Colors.green.shade50 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hovered ? Colors.green.shade500 : Colors.green.shade300,
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

