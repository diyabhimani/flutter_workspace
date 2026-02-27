import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomListExample(),
    );
  }
}

class CustomListExample extends StatefulWidget {
  @override
  _CustomListExampleState createState() => _CustomListExampleState();
}

class _CustomListExampleState extends State<CustomListExample> {
  List<String> items = [
    "Meeting at 10 AM",
    "Grocery Shopping",
    "Finish Homework",
    "Call Mom",
    "Exercise Session",
  ];

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Styled List"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue),
              title: Text(
                items[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteItem(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
