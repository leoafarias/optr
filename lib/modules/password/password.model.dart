import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:optr/modules/secret/secret.model.dart';

class PasswordWithSecret extends Password {
  Secret secret;
  PasswordWithSecret(Password password, this.secret)
      : super(
          id: password.id,
          name: password.name,
          website: password.website,
          version: password.version,
          secretId: password.secretId,
        );
}

class Password implements Comparable<Password> {
  String id;
  String name;
  String username;
  String website;
  int version;
  String secretId;

  Password({
    @required this.id,
    this.name = '',
    this.username = '',
    this.website = '',
    this.version = 1,
    this.secretId = '',
  });

  factory Password.fromMap(Map<dynamic, dynamic> json) => Password(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        website: json['website'],
        version: json['version'],
        secretId: json['secretId'],
      );

  @override
  int compareTo(Password other) {
    return name.compareTo(other.name);
  }

  Map<dynamic, dynamic> toMap() => {
        'id': id,
        'name': name,
        'username': username,
        'website': website,
        'version': version,
        'secretId': secretId,
      };
}

class PasswordAdapter extends TypeAdapter<Password> {
  @override
  int get typeId => 0; // this is unique, no other Adapter can have the same id.

  @override
  Password read(BinaryReader reader) {
    return Password.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, Password obj) {
    writer.writeMap(obj.toMap());
  }
}
