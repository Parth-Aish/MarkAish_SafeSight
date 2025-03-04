import 'package:flutter/material.dart';
import 'dart:async';
import 'final_cta.dart';

class FirstTimeScreen extends StatefulWidget {
  const FirstTimeScreen({super.key});

  @override
  _FirstTimeScreenState createState() => _FirstTimeScreenState();
}

class _FirstTimeScreenState extends State<FirstTimeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const FinalCTAScreen()), // Replace with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Attraction.png', // Make sure this is in your assets folder
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
