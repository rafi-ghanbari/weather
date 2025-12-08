import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_services.dart';

import '../models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // TODO: Replace with your own API key from OpenWeatherMap.
  final _weatherServices = WeatherServices('YOUR_API_KEY_HERE');
  Weather? _weather;
  String _errorMessage = '';

  /// Fetches the current weather based on the user's location.
  _fetchWeather() async {
    setState(() {
      _errorMessage = '';
    });

    String city = '';

    try {
      city = await _weatherServices.getCurrentCity();
      if (city.isEmpty) {
        setState(() {
          _errorMessage =
              'Error: Could not determine current city. Check Location settings.';
        });
        return;
      }

      final weather = await _weatherServices.getWeather(city);
      setState(() {
        _weather = weather as Weather?;
        _errorMessage = 'Weather loaded successfully for $city.';
      });
    } catch (e) {
      String baseError = 'Network/API Error: Failed to fetch weather data.';
      String cityInfo = city.isNotEmpty ? ' (Attempted city: $city)' : '';
      setState(() {
        _errorMessage = '$baseError$cityInfo. Details: ${e.toString()}';
      });
      print("Fetch Error: $e");
    }
  }

  /// Returns the path to the Lottie animation asset based on the weather condition.
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/windy.json';
      case 'dust':
        return 'assets/partly_shower.json';
      case 'rain':
      case 'shower rain':
        return 'assets/partly_shower.json';
      case 'snow':
        return 'assets/snow.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'squall':
        return 'assets/windy.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_weather == null) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                _errorMessage.isNotEmpty
                    ? _errorMessage
                    : 'Loading weather data... Please grant location permission.',
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Text(
                _weather!.cityName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Lottie.asset(getWeatherAnimation(_weather!.mainCondition)),

              const SizedBox(height: 10),
              Text(
                '${_weather!.temperature.round()}°C',
                style: const TextStyle(fontSize: 48, color: Colors.blue),
              ),

              Text(
                _weather!.mainCondition,
                style: TextStyle(fontSize: 18, color: textColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
