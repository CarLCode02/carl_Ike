import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text("BICOL REGION GENERAL HOSPITAL AND GERIATRIC MEDICAL CENTER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 255, 255, 255)),),  
        backgroundColor: const Color.fromARGB(255, 61, 146, 95),
      ), 
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/hospitalbg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 8, 10, 5).withOpacity(0.8), BlendMode.darken
            ),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30 ,),
              Image.network('assets/hlogo.png', height: 260, width: 260,), 
              Text(
  "Citizen's Charter",
  style: GoogleFonts.gloriaHallelujah(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 231, 171, 59),
   
  ),
),

Text(
  "2024 (1ˢᵗ Edition)",
  style: GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 231, 171, 59),
   
  ),
),
SizedBox(height: 10,), 
ElevatedButton(
  style: const ButtonStyle(
    padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 35, vertical: 20)),
    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 61, 146, 95)),
  ),
  child: const Text('Proceed', style: TextStyle(color:Colors.white),),
  onPressed: () {
    // ...
  },
),
            ],
          ), 
        ), 
      ),
    );
  }   
}