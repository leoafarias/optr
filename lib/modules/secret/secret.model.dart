// To parse this JSON data, do
//
//     final masterSecret = masterSecretFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:optr/modules/base.model.dart';
import 'package:optr/modules/device/device.model.dart';

/// Master Secret Model
class Secret implements BaseModel {
  /// Master secret Hash
  String hash;

  /// ID of Master Secret
  @override
  String id;

  /// Label for easy identification of the Master Secret
  String label;

  /// Date generated
  DateTime createdAt;

  /// Count of accounts using this Master Secret
  int accountCount;

  /// Hash to check if values changed
  String valueSignature;

  /// Device information used to generate
  Device device;

  final PasswordType _type = PasswordType.secret;

  /// Constructor
  Secret(
      {this.hash = '',
      this.id,
      this.label = '',
      this.createdAt,
      this.device,
      this.accountCount = 0}) {
    // If no created at time. Timestamp now
    createdAt ??= DateTime.now();
    loadDevice();
  }

  /// Creates Master Secret form Json
  factory Secret.fromJson(String str) => Secret.fromMap(json.decode(str));

  /// Creates Master Seret from Map
  factory Secret.fromMap(Map<String, dynamic> json) => Secret(
        hash: json['hash'],
        id: json['id'],
        label: json['label'],
        accountCount: json['accountCount'],
        device: json['device'] != null ? Device.fromMap(json['device']) : null,
      );

  void loadDevice() async {
    device = await getDevice();
  }

  /// Converts Master Secret to Json
  @override
  String toJson() => json.encode(toMap());

  /// Converts Master Secret to Map
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'label': label,
        'hash': hash,
        'type': _type.toString(),
        'accountCount': accountCount,
        'device': device.toMap(),
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
  void write(BinaryWriter writer, Secret obj) {
    writer.writeMap(obj.toMap());
  }
}
