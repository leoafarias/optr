// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:optr/modules/base.model.dart';

/// Account Model
class Account implements BaseModel {
  /// ID of the account
  @override
  String id;

  /// Identifier of account
  String identifier;

  /// Master ID that the account uses
  String masterId;

  /// Friendly name of the account
  String name;

  /// Version of the account
  int version;

  /// Website of the account
  String website;

  final PasswordType _type = PasswordType.accountPassword;

  /// Constructor
  Account({
    this.id,
    this.identifier,
    this.masterId,
    this.name,
    this.version = 0,
    this.website,
  });

  /// Create Account form Json
  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  /// Creates account from Map
  factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json['id'],
        identifier: json['identifier'],
        masterId: json['masterID'],
        name: json['name'],
        version: json['version'],
        website: json['website'],
      );

  /// Validates model
  @override
  bool validate() {
    return id.isNotEmpty &&
        identifier.isNotEmpty &&
        masterId.isNotEmpty &&
        name.isNotEmpty &&
        !version.isNaN;
  }

  /// Converts Account into JSON
  @override
  String toJson() => json.encode(toMap());

  /// Converts account to Map
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'identifier': identifier,
        'masterID': masterId,
        'name': name,
        'version': version,
        'website': website,
        'type': _type.toString(),
      };
}

class AccountAdapter extends TypeAdapter<Account> {
  @override
  int get typeId => 0; // this is unique, no other Adapter can have the same id.

  @override
  Account read(BinaryReader reader) {
    return Account.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer.writeMap(obj.toMap());
  }
}
