import 'package:flutter/material.dart';
import 'package:weather_app/network/model/weatherDetailDataResponse.dart';
import 'package:weather_app/network/services/weather_services.dart';

class WeatherDetailProvider extends ChangeNotifier {
  WeatherDetailDataResponse _weatherData = WeatherDetailDataResponse();
  bool _isLoading = true;
  String _errorMessage = "";

  // Public getter to access the data.

  bool get isLoading {
    return _isLoading;
  }

  String get errorMessage {
    return _errorMessage;
  }

  WeatherDetailDataResponse get weatherData {
    return _weatherData;
  }

// Setter method for update the data

  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  set errorMessage(String val) {
    _errorMessage = val;

    notifyListeners();
  }

  set weatherData(WeatherDetailDataResponse val) {
    _weatherData = val;

    notifyListeners();
  }

// Method to fetch weather data for a given city.
  Future<void> fetchWeather(String city) async {
    _errorMessage = "";
    try {
      _isLoading = true;

      // Call the API service to get weather data.
      final response = await ApiService().getWeatherDetailData(city);
      _weatherData = response;
      _isLoading = false;
    } catch (e) {
      _errorMessage =
          'No matching location found.'; // If an error occurs, set the error message and set loading state to false.
      _isLoading = false;
      print(e);
    }
    // Notify listeners about the changes in the state.
    notifyListeners();
  }
}
