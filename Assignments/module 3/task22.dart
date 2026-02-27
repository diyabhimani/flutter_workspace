import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

// ------------------- HOME SCREEN -------------------
class HomeScreen extends StatelessWidget {
  final String message = "Hello from Home Screen!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: message, // passing data
                );
              },
              child: Text("Go to Details"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text("Go to Settings"),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- DETAILS SCREEN -------------------
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Receive data passed from Home Screen
    final String message =
    ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details Screen"),
      ),
      body: Center(
        child: Text(
          "Received: $message",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

// ------------------- SETTINGS SCREEN -------------------
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Screen"),
      ),
      body: Center(
        child: Text(
          "Settings Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
