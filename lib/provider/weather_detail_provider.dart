import 'package:flutter/material.dart';
import 'package:weather_app/network/model/weatherDetailDataResponse.dart';
import 'package:weather_app/network/services/weather_services.dart';

class WeatherDetailProvider extends ChangeNotifier {
  WeatherDetailDataResponse _weatherData = WeatherDetailDataResponse();
  bool _isLoading = true;
  String? _errorMessage;

  // Public getter to access the data.
  WeatherDetailDataResponse get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

// Method to fetch weather data for a given city.
  Future<void> fetchWeather(String city) async {
    try {
      _isLoading = true;
      // Call the API service to get weather data.
      final response = await ApiService().getWeatherDetailData(city);
      _weatherData = response;
      _isLoading = false;
    } catch (e) {
      _errorMessage =
          'Failed to load weather data'; // If an error occurs, set the error message and set loading state to false.
      _isLoading = false;
      print(e);
    }
    // Notify listeners about the changes in the state.
    notifyListeners();
  }
}
