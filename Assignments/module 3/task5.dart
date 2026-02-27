import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: task5(),
    );
  }
}

class task5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveRowExample(),
    );
  }
}

class ResponsiveRowExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Responsive Row Layout"),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
              height: 100,
              child: Center(child: Text("Box 1")),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green,
              height: 100,
              child: Center(child: Text("Box 2")),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              height: 100,
              child: Center(child: Text("Box 3")),
            ),
          ),
        ],
      ),
    );
  }
}
