import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: task30(),
    );
  }
}





class task30 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background content
          Column(
            children: [
              // Top empty space (for centered avatar)
              SizedBox(height: 100),

              // Card for name & bio
              Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: Column(
                    children: [
                      Text(
                        "Diya Bhimani",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Flutter Developer | Traveler | Tech Enthusiast",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Centered Profile Image using Positioned
          Positioned(
            top: 30,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://picsum.photos/200/200?random=5",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
