import 'dart:async';
import 'dart:math';

/// Creates Queue
class Character {
  /// From string
  final String from;

  /// To String
  final String to;

  /// Where starts
  final int start;

  /// Where it ends
  final int end;

  /// Character
  String char = '';

  /// Constructor
  Character(this.from, this.to, this.end, this.start);
}

/// Text Scramble
class TextDecoder {
  /// Callback function for update
  final Function(String) fn;

  /// Current text dislpayed
  String currentText;

  /// Animation frame
  int frame;
  final String _chars = '!<>-_\\/[]{}—=+*^?#________';

  /// Scramble duration delay
  Duration delay;
  final List<Character> _queue = <Character>[];

  /// Constructor
  TextDecoder(this.currentText, this.fn,
      {this.delay = const Duration(milliseconds: 1)}) {
    setText(currentText);
  }

  /// Sets initial text
  void setText(String newText) {
    frame = 0;
    var length = max(currentText.length, newText.length);
    final oldText = currentText.padRight(length);
    newText = newText.padRight(length);

    // Clears queue
    _queue.clear();

    for (var i = 0; i < length; i++) {
      final from = oldText[i];
      final to = newText[i];
      final start = Random().nextInt(200);
      final end = start + Random().nextInt(200);
      _queue.add(Character(from, to, end, start));
    }
    update();
  }

  /// Updates text
  void update() async {
    var output = '';
    var complete = 0;
    _queue;

    void createOutput(Character c) {
      if (frame >= c.end) {
        complete++;
        output += c.to;
      } else if (frame >= c.start) {
        // if (c.char.isEmpty || Random().nextDouble() < 0.28) {
        // }
        // Different color letters for loading
        c.char = _randomChar();
        output += c.char;
      } else {
        output += c.from;
      }
    }

    _queue.forEach(createOutput);

    currentText = output;
    fn(currentText);

    // Return if its complete
    if (complete == _queue.length) return;

    frame++;
    Future.delayed(delay, update);
  }

  String _randomChar() {
    return _chars[Random().nextInt(_chars.length)];
  }
}
