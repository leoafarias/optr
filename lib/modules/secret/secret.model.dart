import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType()
class Secret extends HiveObject implements Comparable<Secret> {
  @HiveField(0)
  String id;
  @HiveField(1)
  String hash;
  @HiveField(2)
  String name;
  @HiveField(3)
  HiveList passwords;

  Secret({
    @required this.id,
    this.hash = '',
    this.name = '',
  });

  factory Secret.fromMap(Map<String, dynamic> json) => Secret(
        id: json['id'],
        hash: json['hash'],
        name: json['name'],
      );

  @override
  int compareTo(Secret other) {
    return name.compareTo(other.name);
  }

  Map<String, dynamic> toMap() => {
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
    return Secret.fromMap(reader.readMap())..passwords = reader.read();
  }

  @override
  void write(BinaryWriter writer, Secret secret) {
    writer.write(secret);
    writer.write(secret.passwords);
  }
}
