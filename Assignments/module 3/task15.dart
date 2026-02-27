import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AssetImageDemo(),
    );
  }
}

class AssetImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asset Image BoxFit Demo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            Text("BoxFit.cover", style: TextStyle(fontSize: 18)),
            Container(
              width: 300,
              height: 150,
              color: Colors.grey[300],
              child: Image.asset(
                "assets/images/my_photo.png",
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20),

            Text("BoxFit.contain", style: TextStyle(fontSize: 18)),
            Container(
              width: 300,
              height: 150,
              color: Colors.grey[300],
              child: Image.asset(
                "assets/images/my_photo.png",
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20),

            Text("BoxFit.fill", style: TextStyle(fontSize: 18)),
            Container(
              width: 300,
              height: 150,
              color: Colors.grey[300],
              child: Image.asset(
                "assets/images/my_photo.png",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
