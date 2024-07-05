import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/no_network.dart';
import 'package:weather_app/components/text_widget.dart';
import 'package:weather_app/components/weatherDataComp.dart';
import 'package:weather_app/network/model/weartherListModel.dart';
import 'package:weather_app/provider/weather_detail_provider.dart';
import 'package:weather_app/res/appcolors.dart';
import 'package:weather_app/utils/network_util.dart';

class WeatherDetailScreen extends StatefulWidget {
  final String city;

  const WeatherDetailScreen({required this.city});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text; // Return empty string if input is empty
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherDetailProvider>(context, listen: false)
        .fetchWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherDetailProvider>(context);
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    List<WeatherInfo> weatherList = [
      WeatherInfo(
          title: 'Current Temp',
          data: '${provider.weatherData.current?.tempC}°C'),
      WeatherInfo(
          title: 'Min Temp',
          data:
              '${provider.weatherData.forecast?.forecastday?[0].day?.mintempC}°C'),
      WeatherInfo(
          title: 'Max Temp',
          data:
              '${provider.weatherData.forecast?.forecastday?[0].day?.maxtempC}°C'),
      WeatherInfo(
          title: 'Humidity',
          data: '${provider.weatherData.current?.humidity}%'),
      WeatherInfo(
          title: 'Wind', data: '${provider.weatherData.current?.windKph} kph'),
    ];
    return connectionStatus == ConnectivityStatus.Offline
        ? const Scaffold(body: NoNetwork())
        : Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primaryColor,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.primaryColor2,
                ),
              ),
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                    ? Center(child: Text(provider.errorMessage!))
                    : provider.weatherData == null
                        ? Center(
                            child: TextWidget(
                              txtTitle: 'No data available',
                              txtColor: AppColors.primaryColor2,
                              txtFontStyle: FontWeight.bold,
                              txtFontSize: 20,
                            ),
                          )
                        : OrientationBuilder(
                            builder: (context, orientation) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 55, 16, 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            TextWidget(
                                              txtTitle: capitalizeFirstLetter(
                                                  widget.city),
                                              txtColor: AppColors.white,
                                              txtFontStyle: FontWeight.bold,
                                              txtFontSize: 32,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Image.network(
                                              'https:${provider.weatherData.current?.condition?.icon}',
                                              scale: 0.8,
                                            ),
                                            TextWidget(
                                              txtTitle: provider
                                                      .weatherData
                                                      .current
                                                      ?.condition
                                                      ?.text ??
                                                  "",
                                              txtColor: AppColors.primaryColor2,
                                              txtFontStyle: FontWeight.bold,
                                              txtFontSize: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(top: 30),
                                        height:
                                            orientation == Orientation.portrait
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4
                                                : MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor1,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: GridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisCount: orientation ==
                                                  Orientation.portrait
                                              ? 2
                                              : 4,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: orientation ==
                                                  Orientation.portrait
                                              ? 1.7
                                              : 1.5,
                                          children: List.generate(
                                            weatherList.length,
                                            (index) {
                                              return WeatherDataComp(
                                                title: weatherList[index].title,
                                                data: weatherList[index].data,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          );
  }
}
