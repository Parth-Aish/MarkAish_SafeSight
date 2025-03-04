import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Help",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Terms and Privacy Policy
            _buildHelpItem(
              context,
              title: "Terms and Privacy Policy",
              onTap: () => _showTermsPolicy(context),
            ),
            const SizedBox(height: 15),
            // 2) Report Incident
            _buildHelpItem(
              context,
              title: "Report Incident",
              onTap: () => _showReportIncident(context),
            ),
            const SizedBox(height: 15),
            // 3) App Info
            _buildHelpItem(
              context,
              title: "App Info",
              onTap: () => _showAppInfo(context),
            ),
          ],
        ),
      ),
      // Uncomment the BottomNavigationBar if needed
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white70,
      //   currentIndex: 2,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Nearby"),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      // ),
    );
  }

  /// Builds a tap-able item for the Help screen.
  Widget _buildHelpItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Shows a popup dialog with sample Terms and Privacy Policy text.
  void _showTermsPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Terms and Privacy Policy",
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: const Text(
            "Sample Policy:\n\n1. We respect your privacy.\n2. Your data is protected.\n3. We do not share personal information with third parties.\n\nFor full details, please refer to the official documentation.",
            style: TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  /// Shows a popup dialog for reporting an incident with multiple fields.
  void _showReportIncident(BuildContext context) {
    final TextEditingController incidentTypeController = TextEditingController();
    final TextEditingController incidentDateController = TextEditingController();
    final TextEditingController incidentDescController = TextEditingController();
    final TextEditingController incidentLocationController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Report Incident",
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  controller: incidentTypeController,
                  label: "What kind of incident?",
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: incidentDateController,
                  label: "Which date?",
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: incidentDescController,
                  label: "What happened?",
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: incidentLocationController,
                  label: "Location",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle submission logic here, e.g., send data to server
                Navigator.pop(ctx);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  /// Shows a popup dialog with sample App Info text.
  void _showAppInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "App Info",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Sample App Info:\n\nThis application provides safety and emergency services.\nVersion: 1.0.0\nDeveloper: Your Company",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  /// Helper to build a themed TextField for the dialog forms.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
