import 'package:flutter/material.dart';

class StringPalette {
  final Color borderColor;
  final String initials;
  final Color textColor;
  final Color bgColor;
  StringPalette(
      {this.borderColor, this.initials, this.textColor, this.bgColor});
}

StringPalette colorFromString(String name) {
  // If null set to empty string
  name = name ?? '';
  var initials = (name.length > 2) ? name.substring(0, 2) : name;

  var hash = name.hashCode;
  var r = (hash & 0xFF0000) >> 16;
  var g = (hash & 0x00FF00) >> 8;
  var b = hash & 0x0000FF;

  var mainColor = HSLColor.fromColor(Color.fromRGBO(r, g, b, 1))
      .withSaturation(1)
      .withLightness(0.5);

  var bgColor = mainColor.withLightness(0.5).toColor();
  var borderColor = mainColor.toColor();

  var textColor =
      bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  return StringPalette(
      borderColor: borderColor,
      initials: initials,
      bgColor: bgColor,
      textColor: textColor);
}
