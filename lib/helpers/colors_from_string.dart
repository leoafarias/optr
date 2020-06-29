import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:optr/helpers/brand_colors.g.dart';

// store the keys
final _brandsKeys = brands.keys;

class StringPalette {
  final Color borderColor;
  final String initials;
  final Color textColor;
  final Color bgColor;
  StringPalette({
    this.borderColor,
    this.initials,
    this.textColor,
    this.bgColor,
  });
}

StringPalette colorFromString(String name) {
  var color = searchBrandColor(name);
  color ??= Colors.tealAccent;
  final initials = (name.length > 2) ? name.substring(0, 2) : name;

  var mainColor =
      HSLColor.fromColor(color).withSaturation(1).withLightness(0.5);

  var bgColor = mainColor.withLightness(0.5).toColor();
  var borderColor = mainColor.toColor();

  var textColor =
      bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  return StringPalette(
    borderColor: borderColor,
    initials: initials,
    bgColor: bgColor,
    textColor: textColor,
  );
}

Color searchBrandColor(String term) {
  term = term.toLowerCase().replaceAll(' ', '');
  final key = _brandsKeys.firstWhere(
    (key) => key.startsWith(term),
    orElse: () => null,
  );

  if (key == null) {
    return null;
  }

  return brands[key];
}
