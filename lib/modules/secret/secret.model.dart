import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:optr/modules/password/password.model.dart';

@HiveType()
class Secret implements Comparable<Secret> {
  String id;
  String hash;
  String name;
  List<Password> passwords = [];

  Secret({
    @required this.id,
    this.hash = '',
    this.name = '',
  });

  factory Secret.fromMap(Map<dynamic, dynamic> json) => Secret(
        id: json['id'],
        hash: json['hash'],
        name: json['name'],
      );

  @override
  int compareTo(Secret other) {
    return name.compareTo(other.name);
  }

  Map<dynamic, dynamic> toMap() => {
        'id': id,
        'name': name,
        'hash': hash,
      };
}

class SecretAdapter extends TypeAdapter<Secret> {
  @override
  int get typeId => 1; // this is unique, no other Adapter can have the same id.

  @override
  Secret read(BinaryReader reader) {
    return Secret.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, Secret secret) {
    writer.writeMap(secret.toMap());
  }
}
