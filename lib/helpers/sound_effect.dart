import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

// Only create one sound pool instance
final _pool = Soundpool(streamType: StreamType.notification);

class SoundEffect {
  static Future<int> ask = _load('ask');
  static Future<int> click = _load('click');
  static Future<int> error = _load('error');
  static Future<int> deploy = _load('deploy');
  static Future<int> typing = _load('typing');
  static Future<int> typing_long = _load('typing_long');
  static Future<int> warning = _load('warning');
  static Future<int> information = _load('information');

  static Future<int> play(Future<int> sound) async {
    return _pool.play(await sound);
  }

  static Future<void> pause(int streamId) async {
    return _pool.pause(streamId);
  }

  static Future<void> stop(int streamId) async {
    return _pool.stop(streamId);
  }

  static Future<int> _load(String sound) async {
    final data = await rootBundle.load('assets/sounds/$sound.mp3');
    return _pool.load(data);
  }
}
