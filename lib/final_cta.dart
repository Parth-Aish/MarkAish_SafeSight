import 'package:flutter/material.dart';
import 'contact_registration.dart';

class FinalCTAScreen extends StatefulWidget {
  const FinalCTAScreen({super.key});

  @override
  _FinalCTAScreenState createState() => _FinalCTAScreenState();
}

class _FinalCTAScreenState extends State<FinalCTAScreen> {
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
    });
    // Navigate to the next screen. The loading indicator is shown until the transition.
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ContactRegistrationScreen(),
      ),
    );
    // No need to set _isLoading to false here because the current screen is replaced.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/background_image.png', // Replace with your background image path
            fit: BoxFit.cover,
          ),
          // Register button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter', // Updated font to Inter
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
