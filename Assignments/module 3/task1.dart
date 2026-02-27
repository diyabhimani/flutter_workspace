import 'package:flutter/material.dart';



class task1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello World App"),
        ),
        body: Center(
          child: Text(
            "Hello, Flutter!",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}