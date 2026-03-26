import 'package:flutter/material.dart';

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
        title: Text("CITIZEN'S CHAPTER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),  
        backgroundColor: const Color.fromARGB(255, 61, 146, 95),
      ), 
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/hospitalbg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 8, 10, 5).withOpacity(0.7), BlendMode.darken
            ),
          ),
        ),
      ),
    );
  }
}