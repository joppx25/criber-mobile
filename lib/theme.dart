import 'package:flutter/material.dart';

final ThemeData CriberThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(CriberColors.primary[50].value, CriberColors.primary),

  // Define the default Brightness and Colors
  primaryColor: CriberColors.primary[50],
  accentColor: CriberColors.primary[50],

  // Define the default Font Family
  fontFamily: 'Roboto',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    body1: TextStyle(fontSize: 18.0),

  ),
    buttonColor: Color(0XFF3DC535),
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
);

class CriberColors {
  CriberColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> primary = const <int, Color> {
    50: const Color(0xff233e83),
    100: const Color(0xff233e83),
    200: const Color(0xff233e83),
    300: const Color(0xff233e83),
    400: const Color(0xff233e83),
    500: const Color(0xff233e83),
    600: const Color(0xff233e83),
    700: const Color(0xff233e83),
    800: const Color(0xff233e83),
    900: const Color(0xff233e83)
  };

}