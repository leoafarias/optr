import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType()
class Password extends HiveObject implements Comparable<Password> {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String username;
  @HiveField(3)
  String website;
  @HiveField(4)
  int version;

  Password({
    @required this.id,
    this.name = '',
    this.username = '',
    this.website = '',
    this.version = 1,
  });

  factory Password.fromMap(Map<String, dynamic> json) => Password(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        website: json['website'],
        version: json['version'],
      );

  @override
  int compareTo(Password other) {
    return name.compareTo(other.name);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'username': username,
        'website': website,
        'version': version,
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
