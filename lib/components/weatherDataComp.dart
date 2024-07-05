import 'package:flutter/material.dart';
import 'package:weather_app/components/text_widget.dart';
import 'package:weather_app/res/appcolors.dart';

class WeatherDataComp extends StatelessWidget {
  final String title;
  final String data;
  const WeatherDataComp({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 18, 0, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
              txtTitle: title,
              txtColor: AppColors.primaryColor2,
              txtFontStyle: FontWeight.bold,
              txtFontSize: 14),
          const SizedBox(
            height: 3,
          ),
          TextWidget(
              txtTitle: data,
              txtColor: AppColors.white,
              txtFontStyle: FontWeight.bold,
              txtFontSize: 20),
        ],
      ),
    );
  }
}
