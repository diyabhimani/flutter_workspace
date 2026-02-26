void main() async
{
  print("Fetching weather data...");
  print("Please wait...");

  String result = await fetchWeather();

  print(result);
}
Future<String> fetchWeather() async
{
  await Future.delayed(Duration(seconds: 3));
  return "Weather data loaded successfully.";
}
