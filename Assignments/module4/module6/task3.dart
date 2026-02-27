import 'package:flutter/material.dart';

void main() {
  runApp(const FeedbackApp());
}

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRating;

  // Checkbox values
  bool serviceCheckbox = false;
  bool uiCheckbox = false;
  bool performanceCheckbox = false;
  TextEditingController commentController = TextEditingController();

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      String feedbackData = """
Rating: $selectedRating
Issues Selected:
 - Service: $serviceCheckbox
 - UI: $uiCheckbox
 - Performance: $performanceCheckbox
Comments: ${commentController.text}
""";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Feedback Submitted!")),
      );

      print(feedbackData); // For debugging / backend sending
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Form"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Rate Our App",
                  border: OutlineInputBorder(),
                ),
                value: selectedRating,
                items: ["Excellent", "Good", "Average", "Poor"]
                    .map((item) => DropdownMenuItem(
                  child: Text(item),
                  value: item,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedRating = value);
                },
                validator: (value) =>
                value == null ? "Please select a rating" : null,
              ),

              SizedBox(height: 25),

              Text(
                "What issues did you face?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: Text("Service"),
                value: serviceCheckbox,
                onChanged: (val) =>
                    setState(() => serviceCheckbox = val!),
              ),
              CheckboxListTile(
                title: Text("UI"),
                value: uiCheckbox,
                onChanged: (val) =>
                    setState(() => uiCheckbox = val!),
              ),
              CheckboxListTile(
                title: Text("Performance"),
                value: performanceCheckbox,
                onChanged: (val) =>
                    setState(() => performanceCheckbox = val!),
              ),

              SizedBox(height: 20),
              TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: "Additional Comments",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your comments";
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text("Submit Feedback"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}