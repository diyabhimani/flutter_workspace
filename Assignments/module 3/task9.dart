import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";

  void onButtonClick(String value) {
    setState(() {
      if (display == "0") {
        display = value;
      } else {
        display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          // Display Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.black,
            child: Text(
              display,
              style: TextStyle(color: Colors.white, fontSize: 36),
              textAlign: TextAlign.right,
            ),
          ),

          SizedBox(height: 10),

          // Buttons Section
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/"),
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*"),
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
                buildButton("0"),
                buildButton("."),
                buildButton("="),
                buildButton("+"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () => onButtonClick(value),
      child: Text(
        value,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
