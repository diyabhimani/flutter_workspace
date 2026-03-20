import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomButtonExample(),
    );
  }
}

class CustomButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Button with Icon Overlay"),
      ),
      body: Center(
        child: CustomIconButton(
          icon: Icons.favorite,
          label: "Like",
          onPressed: () {
            print("Button Pressed!");
          },
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Button shape
          Container(
            width: 120,
            padding: EdgeInsets.only(top: 30, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Positioned Icon above the text
          Positioned(
            top: -10,
            child: Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
