import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:optr/modules/base.model.dart';

class Device extends BaseModel {
  final bool redacted;
  final String systemName;
  final String systemVersion;
  final String model;
  final String deviceIdentifier;
  Device({
    this.model = '',
    this.systemName = '',
    this.systemVersion = '',
    this.redacted = false,
    this.deviceIdentifier = '',
  });

  factory Device.fromJson(String str) => Device.fromMap(json.decode(str));

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        redacted: json['redacted'],
        systemName: json['systemName'],
        systemVersion: json['systemVersion'],
        model: json['model'],
        deviceIdentifier: json['deviceIdentifier'],
      );

  String get info {
    return '$model $systemName $systemVersion';
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        'redacted': redacted,
        'systemName': systemName,
        'systemVersion': systemVersion,
        'model': model,
        'deviceIdentifier': deviceIdentifier,
      };
}

Future<Device> getDevice() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      android.model;
      return Device(
        model: android.model,
        systemName: 'android',
        systemVersion: android.version.release,
        deviceIdentifier: android.id,
      );
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      ios.model;

      ios.systemVersion;
      ios.systemName;
      ios.identifierForVendor;
      return Device(
        model: ios.model,
        systemName: ios.systemName,
        systemVersion: ios.systemVersion,
        deviceIdentifier: ios.identifierForVendor,
      );
    }
    return Device(redacted: true);
  } on PlatformException {
    return Device(redacted: true);
  }
}
