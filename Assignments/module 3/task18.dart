import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  String selectedCategory = "General";

  List<String> categories = [
    "General",
    "Bug Report",
    "Feature Request",
    "UI/UX Feedback",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Name Input
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // Comments Input
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Comments",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // Dropdown for Category
            Text(
              "Feedback Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  print("Name: ${nameController.text}");
                  print("Comments: ${commentController.text}");
                  print("Category: $selectedCategory");

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Feedback Submitted!")),
                  );
                },
                child: Text("Submit Feedback"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
