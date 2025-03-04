import 'package:flutter/material.dart';
import 'otp_verification.dart'; // Ensure this screen accepts parameters.
import 'dart:math';
import 'package:http/http.dart' as http;

class ContactRegistrationScreen extends StatefulWidget {
  const ContactRegistrationScreen({super.key});

  @override
  _ContactRegistrationScreenState createState() => _ContactRegistrationScreenState();
}

class _ContactRegistrationScreenState extends State<ContactRegistrationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // Validate that a 10-digit mobile number is provided.
    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty || phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit mobile number.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 1. Generate a 6-digit random OTP.
    final otp = 100000 + Random().nextInt(900000);

    // 2. Compose the message including the OTP.
    final message = "Hello, OTP: $otp";

    // 3. Prepare Telegram Bot API details.
    // Replace with your Telegram Bot Token.
    final botToken = "BOTTOKEN";
    // The Telegram chat id.
    final chatId = "CHATID";

    // Build the Telegram API URL.
    final url = Uri.parse(
      "https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=${Uri.encodeComponent(message)}",
    );

    try {
      // Send the OTP message via HTTP GET.
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If successful, navigate to the OTP verification screen.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(otp: otp),
          ),
        );
      } else {
        // OTP failed to send; show error.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send OTP. Please try again.")),
        );
      }
    } catch (e) {
      // Handle any exceptions.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/contact_registration_illustration.png', // Replace with your illustration image path
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                "Contact Registration",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter', // Updated font to Inter
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Fill your details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(17.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "+91",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[800],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Phone No.',
                              labelStyle: const TextStyle(color: Colors.white),
                              counterText: '', // Hide the counter text
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Please verify the number before proceeding.",
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                                fontFamily: 'Inter',
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
