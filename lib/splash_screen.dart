import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/no_network.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/res/images.dart';
import 'package:weather_app/utils/network_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> launchNextScreen(BuildContext context) async {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    launchNextScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.Offline
        ? const Scaffold(body: NoNetwork())
        : Scaffold(
            body: Center(
              child: Image.asset(
                Images.splash,
                fit: BoxFit.contain,
                width: 200,
                height: 200,
              ),
            ),
          );
  }
}
