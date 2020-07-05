import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Standard blue color
const kBlueColor = Color(0xFF005EFF);

TextTheme _textTheme() {
  return GoogleFonts.titilliumWebTextTheme()
      .copyWith(
        // headline4: GoogleFonts.orbitron(),
        headline5: GoogleFonts.orbitron(),
        headline6: GoogleFonts.orbitron(),
      )
      .apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      );
}

/// Optr dark theme
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    accentColor: Colors.tealAccent,
    cardColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    // buttonColor: Color(0xFF111111),
    cardTheme: const CardTheme(color: Color(0xFF222222), elevation: 0),
    textTheme: _textTheme(),
  );
}
