import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CardWithFAB(),
    );
  }
}

class CardWithFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card with Floating Button"),
      ),
      body: Center(
        child: Stack(
          children: [
            // Card UI
            Container(
              width: 300,
              padding: EdgeInsets.all(20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "This is a sample card with some content inside.\n"
                        "A floating action button is positioned at the bottom-right.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),

            // Positioned Floating Action Button
            Positioned(
              right: 10,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () {
                  print("FAB clicked!");
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
