import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OverlayExample(),
    );
  }
}

class OverlayExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack Overlay Example"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            Container(
              width: 300,
              height: 200,
              child: Image.network(
                "https://picsum.photos/400/300?random=1",
                fit: BoxFit.cover,
              ),
            ),

            // Semi-transparent overlay
            Container(
              width: 300,
              height: 200,
              color: Colors.black.withOpacity(0.4),
            ),

            // Text on top
            Text(
              "Beautiful Overlay",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
