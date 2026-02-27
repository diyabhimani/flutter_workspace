import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PreferencesApp());
}

class PreferencesApp extends StatefulWidget {
  const PreferencesApp({super.key});

  @override
  State<PreferencesApp> createState() => _PreferencesAppState();
}

class _PreferencesAppState extends State<PreferencesApp> {
  TextEditingController nameController = TextEditingController();
  String savedName = "";
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  // Load user preferences from shared_preferences
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString("username") ?? "No name saved";
      darkMode = prefs.getBool("darkMode") ?? false;
    });
  }

  // Save preferences
  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", nameController.text);
    await prefs.setBool("darkMode", darkMode);

    loadPreferences(); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("User Preferences App"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Dark Mode Toggle
              SwitchListTile(
                title: const Text("Enable Dark Mode"),
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: savePreferences,
                child: const Text("Save Preferences"),
              ),

              const SizedBox(height: 30),

              const Text(
                "Saved Preferences:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Text("Saved Name: $savedName"),
              Text("Dark Mode: ${darkMode ? "Enabled" : "Disabled"}"),
            ],
          ),
        ),
      ),
    );
  }
}