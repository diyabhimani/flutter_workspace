import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MovieSearchApp());
}

class MovieSearchApp extends StatelessWidget {
  const MovieSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieHomePage(),
    );
  }
}

class MovieHomePage extends StatefulWidget {
  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? movieData;
  bool loading = false;

  final String apiKey = "379fbdc1"; // Replace with your OMDb API key

  Future<void> searchMovie() async {
    if (searchController.text.isEmpty) return;

    setState(() => loading = true);

    final url = Uri.parse(
        "https://www.omdbapi.com/?t=${searchController.text}&apikey=$apiKey");

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    setState(() {
      movieData = data["Response"] == "True" ? data : null;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Search App"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search Movie",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchMovie,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Loading Spinner
            loading
                ? const CircularProgressIndicator()
                : movieData == null
                ? const Text("Search a movie to see details")
                : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    movieData!["Poster"] != "N/A"
                        ? Image.network(movieData!["Poster"])
                        : const Icon(Icons.movie, size: 100),

                    const SizedBox(height: 10),

                    Text(
                      movieData!["Title"] ?? "",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Text("Year: ${movieData!["Year"]}"),
                    Text("Genre: ${movieData!["Genre"]}"),
                    Text("IMDB Rating: ⭐ ${movieData!["imdbRating"]}"),

                    const SizedBox(height: 10),

                    Text(
                      movieData!["Plot"] ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}