import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController cityController = TextEditingController();

  String temperature = "";
  String description = "";
  String humidity = "";
  bool loading = false;

  Future fetchWeather(String city) async {
    setState(() => loading = true);

    String apiKey = "533f5fb2c7f665830317ab758ed150c7 ";  
    String url =
        "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=533f5fb2c7f665830317ab758ed150c7";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        temperature = data["main"]["temp"].toString();
        description = data["weather"][0]["description"];
        humidity = data["main"]["humidity"].toString();
        loading = false;
      });
    } else {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("City not found!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (cityController.text.isNotEmpty) {
                  fetchWeather(cityController.text);
                }
              },
              child: Text("Get Weather"),
            ),
            SizedBox(height: 30),

            loading
                ? CircularProgressIndicator()
                : Column(
              children: [
                if (temperature.isNotEmpty)
                  Column(
                    children: [
                      Text("Temperature: $temperature°C",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("Description: $description",
                          style: TextStyle(fontSize: 20)),
                      Text("Humidity: $humidity%",
                          style: TextStyle(fontSize: 20)),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}