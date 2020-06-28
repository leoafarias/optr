import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/base.model.dart';
import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/modules/base.repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// MasterSecret Repo Provider
final secretRepoProvider = Provider((_) => SecretRepo());

/// Repository to be used with all password functionality
class SecretRepo extends BaseRepo<Secret> {
  /// Hive box name
  static const boxName = 'secret';

  final _storage = const FlutterSecureStorage();

  /// Constructor for Master Secret Repo
  /// Creates or returns an existing instance of the Master Secret Repo
  SecretRepo() : super();

  /// Gets all Master Secrets
  /// Gets all Account Passwords
  Future<List<Secret>> getAll() async {
    /// Gets all Master Secrets

    final Map<String, dynamic> allValues = await _storage.readAll();
    // await _storage.deleteAll();

    allValues.removeWhere((k, v) {
      var mapValues = json.decode(v);
      return mapValues['type'] != PasswordType.secret.toString();
    });

    final list = <Secret>[];

    allValues.forEach((k, v) {
      var mapValues = json.decode(v);
      list.add(Secret.fromMap(mapValues));
    });

    return list;
  }

  /// Deletes all the Account Passwords on secure storage
  Future<void> removeAll() async {
    var list = await getAll();
    list.forEach(remove);
  }
}
