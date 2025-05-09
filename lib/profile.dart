import 'package:flutter/material.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/message.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int myindex = 2; // Current index for BottomNavigationBar
  String userName = "Vandan Kacha"; // Example user name
  String userEmail = "vandan12@gmail.com"; // Example user email
  String profileImageUrl = "https://randomuser.me/api/portraits/men/1.jpg"; // Example profile image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VibeTribe", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
        centerTitle: true,
        toolbarHeight: 38,
        backgroundColor: Colors.lightBlue[300],
      
        
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.green.shade300,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profileImageUrl),
                      backgroundColor: Colors.grey[300],                      
                    ),
                    SizedBox(height: 15),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
          
              // Profile Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_outline, color: Colors.blue[600]),
                      title: Text("Full Name"),
                      subtitle: Text(userName),
                      onTap: () {
                        
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email_outlined, color:Colors.blue[600]),
                      title: Text("Email"),
                      subtitle: Text(userEmail),
                      onTap: () {
                        // Allow editing email (optional)
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.blue[600]),
                      title: Text("Location"),
                      subtitle: Text("Ahmedabad,India"), 
                      onTap: () {
                        
                      },
                    ),
                  ],
                ),
              ),
          
              // Settings and Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.blue[600]),
                      title: Text("Settings"),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        // Navigate to settings screen
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text("Logout", style: TextStyle(color: Colors.red)),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        // Implement logout logic (e.g., clear user data and navigate to login screen)
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.lightBlue[300],
          onTap: (index) {
            if (index != myindex) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => home()),
                );
              } else if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => message()),
                );
              }
            }
          },
          currentIndex: myindex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.travel_explore_sharp), label: "Manual"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Add logout logic here (e.g., clear shared preferences, navigate to login)
              Navigator.of(context).pop(); // Close dialog
              Navigator.pushReplacementNamed(context, '/login'); // Replace with your login route
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}