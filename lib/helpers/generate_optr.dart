import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:pbkdf2_dart/pbkdf2_dart.dart';

String hashSecret(String secret) {
  final bytes = utf8.encode(secret);
  final digest = sha512.convert(bytes);
  return digest.toString();
}

Future<String> buildPassword(
  String secret, {
  String salt,
  int version = 1,
}) async {
  final gen = PBKDF2(hash: sha512);
  final key = gen.generateKey(secret, salt, 100000 + version, 256);
  final bytes = utf8.encode(key.join());
  final hash = sha256.convert(bytes).toString();
  final first16 = hash.substring(0, 16);
  final spaceEvery4 = first16.replaceAll(RegExp('(?<=^(.{4})+)'), ' ');
  return spaceEvery4;
}
