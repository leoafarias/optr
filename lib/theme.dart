import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Standard blue color
const kBlueColor = Color(0xFF005EFF);

TextTheme _textTheme() {
  return GoogleFonts.titilliumWebTextTheme()
      .copyWith(headline6: GoogleFonts.orbitron())
      .apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      );
}

/// Optr dark theme
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    cardColor: const Color(0xFF111111),
    scaffoldBackgroundColor: Colors.black,
    // buttonColor: Color(0xFF111111),
    cardTheme: const CardTheme(color: Color(0xFF222222), elevation: 0),
    textTheme: _textTheme(),
  );
}

/// Optr dark theme
ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: kBlueColor,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // cardColor: Colors.grey[100],
    cardTheme: CardTheme(color: Colors.grey[100], elevation: 0),
    scaffoldBackgroundColor: kBlueColor,
    buttonColor: Colors.grey[100],
    textTheme: _textTheme(),
  );
}
