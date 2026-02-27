import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageSwitcherScreen(),
    );
  }
}

class ImageSwitcherScreen extends StatefulWidget {
  @override
  _ImageSwitcherScreenState createState() => _ImageSwitcherScreenState();
}

class _ImageSwitcherScreenState extends State<ImageSwitcherScreen> {
  // Two sample network images
  String imageUrl = "https://picsum.photos/300/300?random=1";

  void changeImage() {
    setState(() {
      // Change to a new random image
      imageUrl = "https://picsum.photos/300/300?random=${DateTime.now().millisecond}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Switcher App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 250,
            width: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: changeImage,
            child: Text("Change Image"),
          ),
        ],
      ),
    );
  }
}
