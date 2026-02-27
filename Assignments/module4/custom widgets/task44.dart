import 'package:flutter/material.dart';

class CompleteUIScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "name": "Laptop",
      "price": "₹50000",
      "image": "https://picsum.photos/200?1"
    },
    {
      "name": "Mobile",
      "price": "₹20000",
      "image": "https://picsum.photos/200?2"
    },
    {
      "name": "Headphones",
      "price": "₹3000",
      "image": "https://picsum.photos/200?3"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete UI Example")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 Avatar + Profile Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=5"),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Center(
                child: Text(
                  "Diya Bhimani",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("120", style: TextStyle(fontSize: 18)),
                      Text("Followers"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("80", style: TextStyle(fontSize: 18)),
                      Text("Following"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("35", style: TextStyle(fontSize: 18)),
                      Text("Posts"),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              /// 🔹 Custom Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    print("Follow Clicked");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Follow",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              /// 🔹 Product Catalog Section
              Text(
                "Product Catalog",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Column(
                children: products.map((product) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    child: Row(
                      children: [
                        Image.network(
                          product["image"]!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["name"]!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product["price"]!,
                              style:
                              TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
