import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

//...
Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

Future<Color> colorFromBrand(String name) async {
  final brandMap = await parseJsonFromAssets('assets/test.json');

  // If null set to empty string
  name = name ?? '';
}
