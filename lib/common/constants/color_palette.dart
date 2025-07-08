import 'package:flutter/material.dart';
import 'package:flutter_tflite_examples/common/helpers/get_swatch.dart';

class ColorPalette {
  ColorPalette._();

  static const int primaryColor = 0xff6ACAC6;
  static const int primaryColorDark = 0xff08ACA5;

  static MaterialColor primaryMaterialColor = getSwatch(const Color.fromARGB(255, 0, 0, 0));
  static MaterialColor primaryMaterialColorDark = getSwatch(const Color.fromARGB(255, 4, 6, 6));

  static const int secondaryColor = 0xff3544C4;

  static const Color grey100Color = Color(0xFFEEEEEE);
  static const Color grey200Color = Color(0xFFEEEEEE);
  static const Color grey300Color = Color(0xFFE0E0E0);
  static const Color grey400Color = Color(0xFFBDBDBD);
  static const Color grey500Color = Color(0xFF9E9E9E);
  static const Color grey600Color = Color(0xFF757575);
  static const Color grey700Color = Color(0xFF616161);
  static const Color grey800Color = Color(0xFF424242);
  static const Color grey900Color = Color(0xFF212121);

  static const Color black = Colors.black;
  static const Color grey = Color.fromARGB(255, 123, 126, 130);
  static const Color white = Colors.white;

  static const Color teal = Colors.teal;
}