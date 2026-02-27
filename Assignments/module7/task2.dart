import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  List<dynamic> articles = [];
  bool loading = true;
  final String apiKey = "e7c9928275cd4a79add4676a9d019411";

  @override
  void initState() {
    super.initState();
    fetchNews();
  }


  Future<void> fetchNews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          articles = jsonData["articles"];
          loading = false;
        });
      } else {
        setState(() => loading = false);
        print("Error loading news");
      }
    } catch (e) {
      setState(() => loading = false);
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("News Feed App"),
          backgroundColor: Colors.deepPurple,
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            final imageUrl = article["urlToImage"];
            final title = article["title"] ?? "No Title";
            final description =
                article["description"] ?? "No Description";

            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageUrl != null
                      ? Image.network(imageUrl)
                      : Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text("No Image"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10),
                    child: Text(description),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}