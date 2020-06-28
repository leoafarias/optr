import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/base.model.dart';
import 'package:optr/modules/base.repo.dart';
import 'package:optr/modules/account/account.model.dart';

/// Accouhnt Repo Provider
final accountRepoProvider = Provider((_) => AccountRepo());

/// Repository to be used with all password functionality
class AccountRepo extends BaseRepo<Account> {
  /// Hive box name
  static const boxName = 'account';

  final _storage = const FlutterSecureStorage();

  /// Constructor for Account Repo
  AccountRepo() : super();

  /// Gets all Account Passwords
  Future<List<Account>> getAll() async {
    /// Gets all Master Secrets

    final Map<String, dynamic> allValues = await _storage.readAll();

    allValues.removeWhere((k, v) {
      var mapValues = json.decode(v);
      return mapValues['type'] != PasswordType.account.toString();
    });

    final list = <Account>[];

    allValues.forEach((k, v) {
      var mapValues = json.decode(v);
      var entry = list.add(Account.fromMap(mapValues));
      return entry;
    });

    return list;
  }

  /// Deletes all the Account Passwords on secure storage
  Future<void> removeAll() async {
    var list = await getAll();
    list.forEach(remove);
  }
}
