import 'package:flutter/material.dart';
import 'package:weather_app/components/text_widget.dart';
import 'package:weather_app/res/appcolors.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextWidget(
      txtTitle: "No Network",
      txtFontStyle: FontWeight.w400,
      txtFontSize: 14,
      txtColor: AppColors.black,
    ));
  }
}
