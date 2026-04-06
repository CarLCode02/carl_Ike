import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'dart:async';
import 'package:flutter11th/landing_page.dart';

class ListOfOfficesView extends StatefulWidget {
  final List<String>? buttonNames;
  const ListOfOfficesView({super.key, this.buttonNames});

  @override
  State<ListOfOfficesView> createState() => _ListOfOfficesViewState();
}

class _ListOfOfficesViewState extends State<ListOfOfficesView> {
  String? opened;
   Timer? _inactivityTimer;
     
      Timer? _warningTimer;       //  the 10s countdown alert

  bool _alertVisible = false; 
  int _countdown = 10;       
  Timer? _countdownTimer;

  static const String _pdf1 = 'assets/pdfs/ListOffice.pdf';

  List<String> get services {
    return widget.buttonNames ??
        const [
      'View List of Offices',
      
    ];
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

    //  when 10 seconds remain before timeout
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

  @override
  Widget _buildContent(BuildContext context) {
    if (opened == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'List of Offices',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Service',
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
                      const Text('No PDF YET', style: TextStyle(fontSize: 14)),
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
                  'uda pa su file sadto folder asset\n$assetPath',
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

