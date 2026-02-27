import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Drawer App",
      home: HomeScreen(),
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
            child: Text(
              "Navigation Menu",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        ListTile(
          title: Text("Home"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          },
        ),
        ListTile(
          title: Text("Profile"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            );
          },
        ),
        ListTile(
          title: Text("Settings"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            );
          },
        ),
      ],
    ),
  );
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: buildDrawer(context),
      body: Center(child: Text("Welcome to Home Screen")),
    );
  }
}


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      drawer: buildDrawer(context),
      body: Center(child: Text("Welcome to Profile Screen")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      drawer: buildDrawer(context),
      body: Center(child: Text("Welcome to Settings Screen")),
    );
  }
}