import 'package:flutter/material.dart';
import 'home.dart';
import 'nearby.dart';
import 'settings_screen.dart';

class EmergencySettingsScreen extends StatefulWidget {
  const EmergencySettingsScreen({super.key});

  @override
  _EmergencySettingsScreenState createState() => _EmergencySettingsScreenState();
}

class _EmergencySettingsScreenState extends State<EmergencySettingsScreen> {
  double _shakeIntensity = 0;
  Duration _noiseTolerance = const Duration(minutes: 5);
  bool _disableSOS = false;
  
  // New state variables for toggles and emergency voice code.
  bool _emergencyGestureEnabled = false;
  bool _reportContactsEnabled = false;
  String _emergencyVoiceCode = "";

  // New function for selecting noise tolerance minutes.
  Future<void> _selectNoiseToleranceMinutes(BuildContext context) async {
    TextEditingController controller =
        TextEditingController(text: _noiseTolerance.inMinutes.toString());
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Noise Tolerance Timer"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter minutes",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final int? minutes = int.tryParse(controller.text);
                if (minutes != null) {
                  setState(() {
                    _noiseTolerance = Duration(minutes: minutes);
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // New function to show the emergency voice code input dialog.
  Future<void> _showEmergencyVoiceCodeDialog() async {
    TextEditingController controller =
        TextEditingController(text: _emergencyVoiceCode);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Emergency Voice Code"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Enter code word",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _emergencyVoiceCode = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Emergency Settings",
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Set Emergency Gesture" with on/off switch.
            _buildSwitchSettingsItem(
              title: "Set Emergency Gesture",
              subtitle: "Assigns Alert Signal to power button",
              value: _emergencyGestureEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _emergencyGestureEnabled = newValue;
                });
              },
            ),
            // "Report Contacts" with on/off switch.
            _buildSwitchSettingsItem(
              title: "Report Contacts",
              subtitle: "Sends current location and details to selected contacts",
              value: _reportContactsEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _reportContactsEnabled = newValue;
                });
              },
            ),
            // "Set Emergency Voice Code" that opens a dialog to enter a code word.
            GestureDetector(
              onTap: _showEmergencyVoiceCodeDialog,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Set Emergency Voice Code",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(
                        "Creates an emergency word or phrase to automatically activate the emergency gesture on detection",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Shake Intensity Slider.
            const Text("Shake Intensity",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            const SizedBox(height: 4),
            const Text("Set the vibration intensity on Alert Signal",
                style: TextStyle(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(_shakeIntensity.toInt().toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Slider(
                    value: _shakeIntensity,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    activeColor: Colors.grey[400],
                    inactiveColor: Colors.grey[800],
                    onChanged: (value) {
                      setState(() {
                        _shakeIntensity = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Noise Tolerance Timer (minutes only).
            const Text("Noise Tolerance Timer",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            const SizedBox(height: 4),
            const Text("Set the tolerance for the AI-noise detection",
                style: TextStyle(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectNoiseToleranceMinutes(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "${_noiseTolerance.inMinutes} min",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Disable SOS Widget Switch.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Disable SOS Widget",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    SizedBox(height: 4),
                    Text("Disable the SOS",
                        style: TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
                Switch(
                  value: _disableSOS,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _disableSOS = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NearbyScreen()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }
        },
      ),
    );
  }

  Widget _buildSwitchSettingsItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.blue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Removed unused _buildSettingsItem function
}
