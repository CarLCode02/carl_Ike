import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  

  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
    final String backgroundImage;

    if (orientation == Orientation.portrait) {
      backgroundImage = 'assets/1.JPG';
    } else {
      backgroundImage = 'assets/bg.jpg';
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
            ),
          child: Image.asset(backgroundImage, fit: BoxFit.cover),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 61, 146, 95), Color.fromARGB(135, 0, 0, 0), Color(0xDD000000)],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
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
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Bicol Region General Hospital and Geriatric Medical Center',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      color: Color.fromARGB(255, 231, 171, 56),
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
                         pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                         transitionDuration: const Duration(milliseconds: 500),
                         transitionsBuilder: (context, animation, secondaryAnimation, child) {
                           const begin = Offset(1.0, 0.0); // from right
                           const end = Offset.zero;
                   
                           final tween = Tween(begin: begin, end: end)
                               .chain(CurveTween(curve: Curves.easeInOut));
                   
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
                            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_sharp, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
