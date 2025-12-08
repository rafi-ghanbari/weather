import 'dart:async';
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

/// Service class to handle weather API calls and location services.
class WeatherServices {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

  /// Fetches weather data for a specific [cityName] from OpenWeatherMap API.
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to load weather data. Status: ${response.statusCode}',
      );
    }
  }

  /// Gets the current city name based on the device's geolocation.
  ///
  /// Checks for location permissions and requests them if necessary.
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return "";
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).timeout(const Duration(seconds: 10));
    } on TimeoutException {
      throw Exception("Location fetch timed out after 10 seconds.");
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placemarks[0].locality;
    if (city != null && city.isNotEmpty) {
      List<String> parts = city.split(RegExp(r'[,()،]'));
      city = parts[0].trim();
    }
    return city ?? "London";
  }
}
