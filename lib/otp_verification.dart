import 'package:flutter/material.dart';
import 'home.dart';

class OtpVerificationScreen extends StatefulWidget {
  final int otp; // The OTP that should be matched

  const OtpVerificationScreen({super.key, required this.otp});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  /// Checks if the entered OTP matches the provided OTP.
  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    final input = _otpController.text.trim();
    final enteredOtp = int.tryParse(input);

    // Simulate a brief delay to show the loading indicator
    await Future.delayed(const Duration(seconds: 1));

    if (enteredOtp != null && enteredOtp == widget.otp) {
      // If OTP is correct, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // If OTP is incorrect, show an error message and stop loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect OTP, please try again."),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/otp_sent.png', // Replace with your OTP sent icon path
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "OTP has been sent!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Enter OTP',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: 'XXX-XXX',
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: '', // Hides the counter text
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter the code sent to your number",
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Resend button navigates back to the previous screen.
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Resend",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
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
                            "Verify",
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
            ],
          ),
        ),
      ),
    );
  }
}
