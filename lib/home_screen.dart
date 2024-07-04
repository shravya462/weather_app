import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/components/text_widget.dart';
import 'package:weather_app/res/api_constants.dart';
import 'package:weather_app/res/appcolors.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  List _cities = [];
  String errorMessage = "";

  Future<void> newsApi(String city) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.get(Uri.parse(
          "${APIUrlConstants.baseUrl}${APIUrlConstants.searchWeather}&q=$city"));
      if (response.statusCode == 200) {
        setState(() {
          _cities = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _cities = [];
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle the error by displaying a message or taking other actions
      print("Error fetching news data: $e");
      // You can set an error message to display in the UI if needed
      setState(() {
        _isLoading = false;
        errorMessage = "error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(
              txtTitle: "Weather Now",
              txtColor: AppColors.white,
              txtFontStyle: FontWeight.bold,
              txtFontSize: 18),
          backgroundColor: AppColors.primaryColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onChanged: (String val) {
                setState(() {
                  newsApi(val);
                  print("showroomByLocation:${val}");
                });
              },
            ),
          ),
          _isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: _cities.length,
                    itemBuilder: (context, index) {
                      final city = _cities[index];
                      return ListTile(
                        title: Text(city['name']),
                        subtitle: Text(
                            'Region: ${city['region']}, Country: ${city['country']}'),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         DetailScreen(city: city['name']),
                          //   ),
                          // );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
