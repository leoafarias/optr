import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Hashes value
String sha3Hash(String value) {
  var bytes = utf8.encode(value);
  return sha256.convert(bytes).toString();
}
