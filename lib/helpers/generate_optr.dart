import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<String> generateOptr(String value) async {
  final bytes = utf8.encode(value);
  final hash = sha256.convert(bytes).toString();
  final first16 = hash.substring(0, 16);
  final spaceEvery4 = first16.replaceAll(RegExp('(?<=^(.{4})+)'), ' ');
  return spaceEvery4;
}
