import 'package:flutter/material.dart';
import 'dart:async';
import 'first_time_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () { // Set the duration as per your preference
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const FirstTimeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 50), // Add some space at the top
          Column(
            children: [
              const SafeSightLogo(),
              const SizedBox(height: 20),
              const Text(
                "Women's Safety is our Priority",
                style: TextStyle(
                  color: Color(0xFF868484), // Updated color code
                  fontSize: 18, // Updated font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter', // Updated font to Inter
                ),
                textAlign: TextAlign.center, // Center-align the text
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 40), // Padding to add some space from the bottom
            child: Text(
              "An initiative towards women safety",
              style: TextStyle(
                color: Color(0xFF868484), // Updated color code
                fontSize: 12, // Updated font size
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter', // Updated font to Inter
              ),
              textAlign: TextAlign.center, // Center-align the text
            ),
          ),
        ],
      ),
    );
  }
}

class SafeSightLogo extends StatelessWidget {
  const SafeSightLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.remove_red_eye,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "SafeSight  ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter', // Ensure consistent font usage
              ),
              textAlign: TextAlign.center, // Center-align the text
            ),
          ],
        ),
      ],
    );
  }
}