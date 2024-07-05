import 'package:http/http.dart' as http;
import 'package:weather_app/network/model/weatherDetailDataResponse.dart';
import 'package:weather_app/res/api_constants.dart';

class ApiService {
  Future<WeatherDetailDataResponse> getWeatherDetailData(String city) async {
    try {
      // Make an HTTP GET request to the weather API with the specified city and parameters.
      final response = await http.get(Uri.parse(
          "${APIUrlConstants.baseUrl}${APIUrlConstants.currentWeather}&q=$city&days=1"));

      if (response.statusCode == 200) {
        print(response.statusCode);
        // Parse the response body and return a WeatherDetailDataResponse object.
        return weatherDetailData(response.body.toString());
      } else {
        throw Exception('Failed to load news articles');
      }
    } catch (e) {
      // Catch any errors that occur during the request and throw an exception .
      throw Exception('Failed to load news articles: $e');
    }
  }
}
