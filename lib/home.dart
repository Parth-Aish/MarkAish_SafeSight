import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'nearby.dart';
import 'settings_screen.dart';

// A simple model for a Contact.
class Contact {
  final String name;
  final String phone;
  Contact({required this.name, required this.phone});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for adding a new contact.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // List to store saved contacts.
  final List<Contact> _contacts = [];
  
  // Telegram configuration.
  final String telegramBotToken = "BOT_TOKEN";
  final String telegramChatId = "CHATOID";
  
  // Common bold Inter text style.
  final TextStyle boldStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  /// Sends a Telegram message (for prototype purposes).
  Future<void> _sendTelegramMessage(String message) async {
    final url = Uri.parse(
      "https://api.telegram.org/bot$telegramBotToken/sendMessage?chat_id=$telegramChatId&text=${Uri.encodeComponent(message)}"
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location sent to Telegram", style: boldStyle))
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending Telegram message", style: boldStyle))
      );
    }
  }
  
  /// Displays a dialog to add a new contact.
  void _showAddContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text("Add Contact", style: boldStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                style: boldStyle,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: boldStyle,
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                style: boldStyle,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: boldStyle,
                  filled: true,
                  fillColor: Colors.grey[800],
                  counterText: "", // Hides the counter.
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && _phoneController.text.length == 10) {
                  setState(() {
                    _contacts.add(Contact(
                      name: _nameController.text,
                      phone: _phoneController.text,
                    ));
                  });
                  _nameController.clear();
                  _phoneController.clear();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter valid name and 10-digit number", style: boldStyle))
                  );
                }
              },
              child: Text("Save", style: boldStyle.copyWith(color: Colors.blue)),
            ),
          ],
        );
      }
    );
  }
  
  /// Displays a confirmation dialog before deleting a contact.
  void _showDeleteConfirmation(Contact contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text("Delete Contact?", style: boldStyle),
          content: Text("Are you sure you want to delete ${contact.name}?", style: boldStyle),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: boldStyle.copyWith(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _contacts.remove(contact);
                });
                Navigator.pop(context);
              },
              child: Text("Delete", style: boldStyle.copyWith(color: Colors.red)),
            ),
          ],
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // AppBar with title and no back arrow.
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back arrow.
        backgroundColor: Colors.grey[900],
        title: Text("SafeSight", style: boldStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Threat Indicator Section.
            Text("Threat Indicator", style: boldStyle.copyWith(fontSize: 20)),
            const SizedBox(height: 10),
            // Thinner LinearProgressIndicator.
            SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value: 0.23,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text("Relatively Safe Location and Time", style: boldStyle.copyWith(color: Colors.green)),
            const SizedBox(height: 20),
            // Dedicated Location Button in the Body.
            ElevatedButton.icon(
              onPressed: () {
                _sendTelegramMessage("https://www.google.com/maps/place/Chandigarh+University/@30.7728677,76.5789888,15z/data=!4m6!3m5!1s0x390fedc134ed2ff3:0xbe462f3634df604f!8m2!3d30.7715364!4d76.5788366!16s%2Fg%2F1ptxwz6s_?entry=ttu&g_ep=EgoyMDI1MDIxMC4wIKXMDSoASAFQAw%3D%3D");
              },
              icon: const Icon(Icons.location_on, color: Colors.white),
              label: Text("Location", style: boldStyle.copyWith(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(height: 20),
            // Nearby Partners Section.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nearby Partners", style: boldStyle.copyWith(fontSize: 20)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyScreen()));
                  },
                  child: Text("View All", style: boldStyle.copyWith(color: Colors.blue)),
                ),
              ],
            ),
            // A sample nearby partner card for VR Punjab.
            Card(
              color: Colors.grey[850],
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown,
                  child: Text("VR", style: boldStyle),
                ),
                title: Text("VR Punjab", style: boldStyle),
                onTap: () {
                  // When VR Punjab is tapped, open the NearbyScreen.
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyScreen()));
                },
              ),
            ),
            const SizedBox(height: 20),
            // Saved Contacts Section Header with an Add button.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Saved Contacts", style: boldStyle.copyWith(fontSize: 20)),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: _showAddContactDialog,
                ),
              ],
            ),
            // Expanded list of Saved Contacts (non-clickable).
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return Card(
                    color: Colors.grey[850],
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      // No onTap - the contact is non-clickable.
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: Text(contact.name.substring(0, 1).toUpperCase(), style: boldStyle),
                      ),
                      title: Text(contact.name, style: boldStyle),
                      subtitle: Text(contact.phone, style: boldStyle),
                      // Dedicated delete icon shows a confirmation dialog.
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmation(contact);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Nearby"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }
        },
      ),
    );
  }
}
