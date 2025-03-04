import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'settings_screen.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  Future<void> _openGoogleMaps(BuildContext context) async {
    // Your provided URL.
    final String urlString =
        "https://www.google.com/maps?sca_esv=abfc99f64281ab7f&iflsig=ACkRmUkAAAAAZ63sxYJ4ibdFpjB3qzqSsmMkg1x84L2a&gs_lp=Egdnd3Mtd2l6IgZ2ciBwdW4qAggBMg4QLhiABBjHARiOBRivATIREC4YgAQYsQMYxwEYjgUYrwEyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyCxAuGIAEGMcBGK8BMgsQLhiABBjHARivAUi2GVAAWJcNcAB4AJABAJgB8gGgAZ4HqgEFMC40LjG4AQPIAQD4AQGYAgWgArAHwgIIEC4YgAQYsQPCAggQABiABBixA8ICDhAuGIAEGLEDGNEDGMcBwgILEAAYgAQYsQMYgwHCAgQQABgDwgILEAAYgAQYsQMYigWYAwCSBwUwLjMuMqAHuEE&um=1&ie=UTF-8&fb=1&gl=in&sa=X&geocode=KQPT2ynP7w85MSZzjJoIHMTN&daddr=NH-21,+Chandigarh+Kharar,+Chandigarh+Rd,+Sector+118,+Sahibzada+Ajit+Singh+Nagar,+Punjab+160055";
    final Uri googleMapsUri = Uri.parse(urlString);

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open Google Maps")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back arrow.
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Nearby Partners",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.grey[850],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with rounded top corners.
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  "assets/vr_punjab.png",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Details section.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "VR Punjab",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "NH-21, Chandigarh Kharar, Chandigarh Rd, Sector 118, Sahibzada Ajit Singh Nagar, Punjab 160055",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Icon(Icons.access_time, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Open · Closes 11 PM",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.timer, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Estm. Time: 12 min",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Distance: 1.5 km",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () => _openGoogleMaps(context),
                        icon: const Icon(Icons.directions, color: Colors.white),
                        label: const Text("Directions", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
      // Bottom Navigation Bar with onTap logic.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Nearby"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to HomeScreen.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 2) {
            // Navigate to SettingsScreen.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }
          // If index == 1, you're already on the NearbyScreen.
        },
      ),
    );
  }
}
