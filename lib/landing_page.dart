import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'homepage.dart';
import 'user_guide.dart'; // user guide chatbot button and dialog

// amo nadi logo animation - converted to StatefulWidget to support AnimationController
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  // amo nadi logo animation - single controller drives all animations
  late final AnimationController _controller;

  // Amo nadi timer - tracks current time, updated every second
  late DateTime _now;
  Timer? _clockTimer; // Amo nadi timer

  // amo nadi logo animation - scale: logo grows from 0.4 to 1.0
  late final Animation<double> _scaleAnim;

  // amo nadi logo animation - fade: everything fades in from 0 to 1
  late final Animation<double> _fadeAnim;

  // amo nadi logo animation - slide: content rises up slightly on enter
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    // Amo nadi timer - initialize with current time
    _now = DateTime.now();
    // Amo nadi timer - tick every second to keep time live
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });

    // amo nadi logo animation - 900ms total duration for the entrance
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // amo nadi logo animation - scale bounces in with elasticOut for a lively feel
    _scaleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // amo nadi logo animation - fade covers the full duration smoothly
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // amo nadi logo animation - content slides up from slightly below
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // amo nadi logo animation - start the animation as soon as the page loads
    _controller.forward();
  }

  @override
  void dispose() {
    _clockTimer?.cancel(); // Amo nadi timer - stop the timer on dispose
    _controller.dispose(); // amo nadi logo animation - always dispose the controller
    super.dispose();
  }

  // Amo nadi timer - pads single digits with a leading zero (e.g. 9 → "09")
  String _pad(int n) => n.toString().padLeft(2, '0');

  // Amo nadi timer - converts 24h hour to 12h and returns AM/PM label
  String get _amPm => _now.hour < 12 ? 'am' : 'pm';

  // Amo nadi timer - converts 24h to 12h format (0 → 12, 13 → 1, etc.)
  int get _hour12 {
    final h = _now.hour % 12;
    return h == 0 ? 12 : h;
  }

  // Amo nadi timer - formats time as hh:MM:SS (no AM/PM, shown separately)
  String get _timeString =>
      '${_pad(_hour12)}:${_pad(_now.minute)}:${_pad(_now.second)}';

  // Amo nadi timer - formats date as "Wednesday, April 1, 2026"
  String get _dateString {
    const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    const months = ['January','February','March','April','May','June',
                    'July','August','September','October','November','December'];
    return '${days[_now.weekday - 1]}, ${months[_now.month - 1]} ${_now.day}, ${_now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final String backgroundImage =
        orientation == Orientation.portrait ? 'assets/1.JPG' : 'assets/bg.jpg';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // background image
          Image.asset(backgroundImage, fit: BoxFit.cover),

          // dark gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 61, 146, 95),
                  Color.fromARGB(135, 0, 0, 0),
                  Color(0xDD000000),
                ],
              ),
            ),
          ),

          // Amo nadi timer - live clock pinned to the top center of the screen
          Positioned(
            top: 32,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Amo nadi timer - time and AM/PM in a Row so AM/PM can have its own smaller size
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _timeString,
                      style: GoogleFonts.inter(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, bottom: 6),
                      child: Text(
                        _amPm,
                        // time am pm size - smaller than the main time digits
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _dateString,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              // amo nadi logo animation - SlideTransition lifts content upward on enter
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // amo nadi logo animation - ScaleTransition makes the logo pop in
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              blurRadius: 30,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHMyvIs_OKj60qVtecCudySQlfVXsjwIrZ8w&s',
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Bicol Region General Hospital and Geriatric Medical Center',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          color: const Color.fromARGB(255, 231, 171, 56),
                          fontWeight: FontWeight.w800,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 80,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Citizen's Charter",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 27,
                        color: const Color.fromARGB(255, 243, 243, 235),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.green.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  const HomePage(),
                              transitionDuration: const Duration(milliseconds: 500),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                final tween = Tween(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).chain(CurveTween(curve: Curves.easeInOut));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('PROCEED',
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_sharp, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // user guide chatbot button — lower left corner of the landing page
          const UserGuideButton(),
        ],
      ),
    );
  }
}
