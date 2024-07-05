import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_detail_provider.dart';
import 'package:weather_app/splash_screen.dart';
import 'package:weather_app/utils/network_util.dart';

void main() {
  runApp(MultiProvider(providers: [
    StreamProvider<ConnectivityStatus>(
      create: (ctx) => NetworkUtil().connectionStatusController.stream,
      initialData: ConnectivityStatus.WiFi,
    ),
    ChangeNotifierProvider(
      create: (context) => WeatherDetailProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Now',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
