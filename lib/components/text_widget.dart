import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String txtTitle;
  final Color txtColor;
  final FontWeight txtFontStyle;
  final double txtFontSize;
  final TextAlign? textAlignment;
  final bool wrapValue;
  final TextOverflow? overflow;

  const TextWidget({
    required this.txtTitle,
    required this.txtColor,
    required this.txtFontStyle,
    required this.txtFontSize,
    this.textAlignment,
    this.overflow = TextOverflow.visible,
    this.wrapValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txtTitle,
      softWrap: wrapValue,
      overflow: overflow,
      style: GoogleFonts.ebGaramond(
        fontSize: txtFontSize,
        fontWeight: txtFontStyle,
        color: txtColor, // White text color
      ),
      textAlign: textAlignment != null ? textAlignment : TextAlign.start,
    );
  }
}
