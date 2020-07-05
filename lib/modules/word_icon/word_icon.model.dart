import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:optr/modules/base.model.dart';

/// WordIcon Model
class WordIcon implements BaseModel {
  /// Word
  String word;

  /// ID of Icon
  @override
  String id;

  /// Attribution to the icon
  String attribution;

  /// WordIcon binary
  Uint8List image;

  /// Constructor
  WordIcon({
    @required this.id,
    @required this.word,
    @required this.image,
    this.attribution,
  });

  /// Creates WordIcon form Json
  factory WordIcon.fromJson(String str) => WordIcon.fromMap(json.decode(str));

  /// Creates Seret from Map
  factory WordIcon.fromMap(Map<dynamic, dynamic> json) => WordIcon(
        id: json['id'] ?? json['icon_id'],
        word: json['word'],
        image: json['image'],
        attribution: json['attribution'],
      );

  /// Converts WordIcon to Json
  @override
  String toJson() => json.encode(toMap());

  /// Converts WordIcon to Map
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'word': word,
        'image': image,
        'attribution': attribution,
      };

  @override
  String toString() {
    return 'WordIcon{ '
        'id: $id, '
        'word: $word, '
        'attribution: $attribution, '
        'image: ${image.lengthInBytes} bytes '
        '}';
  }
}

class WordIconAdapter extends TypeAdapter<WordIcon> {
  @override
  int get typeId => 2; // this is unique, no other Adapter can have the same id.

  @override
  WordIcon read(BinaryReader reader) {
    return WordIcon.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, WordIcon obj) {
    writer.writeMap(obj.toMap());
  }
}
