import 'package:flutter/material.dart';
import 'home.dart';
import 'nearby.dart';
import 'sos_emergency_screen.dart';
import 'notifications_screen.dart';
import 'help_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes back arrow
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsItem(
              icon: Icons.sos,
              title: "SOS Emergency Settings",
              isBold: true,
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const EmergencySettingsScreen()));
              },
            ),
            const SizedBox(height: 20),
            _buildSettingsItem(
              icon: Icons.notifications,
              title: "Notifications",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
              },
            ),
            const SizedBox(height: 20),
            _buildSettingsItem(
              icon: Icons.language,
              title: "App Language",
              onTap: () {
                _showLanguageSelection(context);
              },
            ),
            const SizedBox(height: 20),
            _buildSettingsItem(
              icon: Icons.help,
              title: "Help",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen()));
              },
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Nearby"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NearbyScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isBold = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

void _showLanguageSelection(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) {
      return const LanguageSelectionSheet();
    },
  );
}

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  _LanguageSelectionSheetState createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("App language",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildLanguageOption("English", "device’s default"),
          _buildLanguageOption("हिंदी", "Hindi"),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, String subtitle) {
    return RadioListTile(
      title: Text(language, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      value: language,
      groupValue: _selectedLanguage,
      activeColor: Colors.blue,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
    );
  }
}
