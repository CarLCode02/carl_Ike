import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'homepage.dart';
import 'user_guide.dart'; // the user guide button shown on this page

// amo nadi logo animation - this page needs animation so it uses StatefulWidget
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  // amo nadi logo animation - one controller runs all three animations together
  late final AnimationController _controller;

  // Amo nadi timer - holds the current time, gets updated every second
  late DateTime _now;
  Timer? _clockTimer; // Amo nadi timer

  // amo nadi logo animation - makes the logo grow from small to full size
  late final Animation<double> _scaleAnim;

  // amo nadi logo animation - makes everything fade in from invisible to visible
  late final Animation<double> _fadeAnim;

  // amo nadi logo animation - makes the content slide up a little when it appears
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    // Amo nadi timer - set the time right away when the page opens
    _now = DateTime.now();
    // Amo nadi timer - update the clock every second
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });

    // amo nadi logo animation - the whole animation takes 900ms
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // amo nadi logo animation - logo bounces in, elasticOut gives it a springy feel
    _scaleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // amo nadi logo animation - everything fades in smoothly over the full duration
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // amo nadi logo animation - content starts a little below and moves up
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // amo nadi logo animation - start playing the animation right away
    _controller.forward();
  }

  @override
  void dispose() {
    _clockTimer?.cancel(); // Amo nadi timer - stop the clock when leaving this page
    _controller.dispose(); // amo nadi logo animation - clean up the animation
    super.dispose();
  }

  // Amo nadi timer - adds a zero in front of single digit numbers like 9 becomes 09
  String _pad(int n) => n.toString().padLeft(2, '0');

  // Amo nadi timer - checks if it is morning or afternoon
  String get _amPm => _now.hour < 12 ? 'am' : 'pm';

  // Amo nadi timer - converts 24 hour time to 12 hour, midnight and noon become 12
  int get _hour12 {
    final h = _now.hour % 12;
    return h == 0 ? 12 : h;
  }

  // Amo nadi timer - builds the time string without AM/PM since that is shown separately
  String get _timeString =>
      '${_pad(_hour12)}:${_pad(_now.minute)}:${_pad(_now.second)}';

  // Amo nadi timer - builds the full date string like Wednesday, April 1, 2026
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

          // dark green to black gradient on top of the image so text is readable
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

          // Amo nadi timer - clock sitting at the top center of the screen
          Positioned(
            top: 32,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Amo nadi timer - time and AM/PM side by side, AM/PM is smaller
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
                        // time am pm size - AM/PM is smaller so it looks like a label not a number
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
            // amo nadi logo animation - everything fades in together
            child: FadeTransition(
              opacity: _fadeAnim,
              // amo nadi logo animation - content slides up when it appears
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // amo nadi logo animation - logo pops in from small to full size
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

          // user guide button sitting at the bottom right corner
          const UserGuideButton(),
        ],
      ),
    );
  }
}
