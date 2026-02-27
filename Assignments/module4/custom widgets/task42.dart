import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProgressBarScreen(),
    );
  }
}
class ProgressBarScreen extends StatelessWidget {
  final double percentage; // value between 0.0 to 1.0

  ProgressBarScreen({this.percentage = 0.6}); // default 60%

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Progress Bar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Progress: ${(percentage * 100).toInt()}%",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),

            Container(
              width: 250,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 250 * percentage,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
