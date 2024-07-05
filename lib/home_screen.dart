import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/no_network.dart';
import 'package:weather_app/components/text_widget.dart';
import 'package:weather_app/res/appcolors.dart';
import 'package:weather_app/utils/network_util.dart';
import 'package:weather_app/weather_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.Offline
        ? const Scaffold(body: NoNetwork())
        : Scaffold(
            backgroundColor: const Color.fromRGBO(11, 18, 30, 1),
            body: SafeArea(
              child: LayoutBuilder(
                // Build the UI inside LayoutBuilder to dynamically adjust  across various device sizes
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      // Control the size of its child widget, ensuring it stays within certain size limits
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Search Bar
                            const SizedBox(height: 50.0),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, color: Colors.grey),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter city name...",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 80.0),
                            // Informative Text
                            const TextWidget(
                                txtTitle: 'Hello, Weather Enthusiast!',
                                txtColor: AppColors.white,
                                txtFontStyle: FontWeight.bold,
                                txtFontSize: 26),

                            const SizedBox(height: 20.0),
                            const TextWidget(
                              txtTitle:
                                  'Stay updated with the latest weather\nforecasts for your favorite places.',
                              txtColor: AppColors.primaryColor2,
                              txtFontStyle: FontWeight.w400,
                              txtFontSize: 18,
                              textAlignment: TextAlign.center,
                            ),

                            const SizedBox(height: 350.0),
                            // Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: 15.0),
                              ),
                              onPressed: () {
                                if (_searchController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Please enter a city name",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: AppColors.white,
                                    textColor: AppColors.primaryColor2,
                                  );
                                } else {
                                  // Navigate to detail screen if city name is not empty
                                  Navigator.of(context).push(_detailScreenRoute(
                                      _searchController.text));
                                  _searchController.text = "";
                                }
                              },
                              child: const TextWidget(
                                txtTitle: 'Show Weather Details',
                                txtColor: AppColors.white,
                                txtFontStyle: FontWeight.w400,
                                txtFontSize: 18,
                                textAlignment: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 50.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}

// Animation that occurs while navigating to WeatherDetail screen
Route _detailScreenRoute(String city) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        WeatherDetailScreen(city: city),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(
      milliseconds: 500,
    ),
    reverseTransitionDuration: const Duration(
      milliseconds: 500,
    ),
  );
}
