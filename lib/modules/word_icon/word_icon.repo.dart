import 'dart:math';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/word_icon/word_icon.model.dart';
import 'package:optr/modules/base.repo.dart';

export 'package:optr/modules/word_icon/word_icon.model.dart';

/// WordIcon Repo Provider
final wordIconRepoProvider = Provider((_) => WordIconRepo());

/// Repository to be used with all words functionality
class WordIconRepo extends BaseRepo<WordIcon> {
  /// Hive box name
  static const boxName = 'word_info';
  static final box = Hive.box<WordIcon>(boxName);

  static void openBox() async {
    final bytes = await rootBundle.load('assets/word_icon.hive');
    await Hive.openBox<WordIcon>(boxName, bytes: bytes.buffer.asUint8List());
  }

  /// Constructor for WordIcon Repo
  /// Creates or returns an existing instance of the WordIcon Repo
  WordIconRepo() : super();

  /// Return random words
  static List<WordIcon> generate({int amount = 4}) {
    final rand = Random.secure();

    return List<WordIcon>.generate(amount, (i) {
      final index = rand.nextInt(box.length - 1);
      return box.getAt(index);
    });
  }
}
