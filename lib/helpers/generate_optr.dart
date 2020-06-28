import 'dart:convert';
import 'package:cryptography/cryptography.dart';

Future<String> generateOptr(String value, String salt) async {
  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac(sha256),
    iterations: 1000,
    bits: 256,
  );

  final hashBytes = await pbkdf2.deriveBits(
    utf8.encode('valuesalt'),
    nonce: Nonce(utf8.encode('valuesalt')),
  );

  return base64.encode(hashBytes);
}
