import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NameListScreen(),
    );
  }
}

class NameListScreen extends StatelessWidget {
  final List<String> names = [
    "Diya",
    "Aarav",
    "Priya",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Names List"),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(names[index]),
            onTap: () {
              print("Name tapped: ${names[index]}");
            },
          );
        },
      ),
    );
  }
}
