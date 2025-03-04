import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _threatAlert = false;
  bool _telegramAlert = false;
  double _threshold = 0.5; // Default threshold value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Notifications",
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
            _buildSwitchTile(
              "Threat Alert",
              "Sends notifications on threat detection",
              _threatAlert,
              (value) => setState(() => _threatAlert = value),
            ),
            const SizedBox(height: 15),
            const Text(
              "Set Threshold",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              "Sends notification after minimum threshold",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            _buildGradientSlider(),
            const SizedBox(height: 15),
            _buildSwitchTile(
              "Telegram Alert",
              "Sends an alert message on telegram",
              _telegramAlert,
              (value) => setState(() => _telegramAlert = value),
            ),
          ],
        ),
      ),
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

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: Colors.blue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildGradientSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackShape: const RectangularSliderTrackShape(),
        trackHeight: 10,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
      ),
      child: Slider(
        value: _threshold,
        min: 0,
        max: 1,
        divisions: 100,
        activeColor: Colors.red,
        inactiveColor: Colors.green,
        onChanged: (value) {
          setState(() {
            _threshold = value;
          });
        },
      ),
    );
  }
}
