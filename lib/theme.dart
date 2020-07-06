import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Standard blue color
const kBlueColor = Color(0xFF005EFF);

TextTheme _textTheme() {
  return GoogleFonts.titilliumWebTextTheme().copyWith().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      );
}

/// Optr dark theme
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    accentColor: Colors.grey,
    cardColor: const Color(0xFF111111),
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    // buttonColor: Color(0xFF111111),
    cardTheme: const CardTheme(elevation: 0),
    textTheme: _textTheme(),
  );
}
