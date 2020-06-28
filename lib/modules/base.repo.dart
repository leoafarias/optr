import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:optr/modules/base.model.dart';

/// Repository to be used with all password functionality
abstract class BaseRepo<T extends BaseModel> {
  /// Constructor
  BaseRepo();

  final _storage = const FlutterSecureStorage();

  /// Saves password to secure storage
  Future<void> save(T model) async {
    // Store password on secure storage
    if (!model.validate()) {
      throw Exception('Model is not valid');
    }

    await _storage.write(key: model.id, value: model.toJson());

    // Adds updated model to password list
  }

  /// Deletes a Password Model from storage
  Future<void> remove(T model) async {
    await _storage.delete(key: model.id);
  }
}
