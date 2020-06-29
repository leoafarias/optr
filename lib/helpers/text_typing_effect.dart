import 'dart:async';

String _replaceCharAt(String oldString, int index, String newChar) {
  final start = oldString.substring(0, index);
  final end = oldString.substring(index + 1);
  return start + newChar + end;
}

String _removeLastChar(String str) {
  return str.substring(0, str.length - 1);
}

/// Text Scramble
class TypingEffect {
  /// Callback function for update
  final Function(String) fn;

  /// Current text displayed
  String _text;

  /// Delay between letters
  Duration _delay;

  /// Constructor
  TypingEffect(String text, this.fn,
      {duration = const Duration(milliseconds: 800)}) {
    // Create delay based on text length
    _delay = calculateDelay(text, duration);
    setText(text);
  }

  // Create delay based on text length
  Duration calculateDelay(String text, Duration duration) {
    final steps = text.length * 2;
    // Conver to int
    final delayInMicroSeconds = duration.inMicroseconds ~/ steps;
    return Duration(microseconds: delayInMicroSeconds);
  }

  /// Sets initial text
  void setText(String newText) async {
    /// Removes text
    /// Needs to have length > 0

    _text = ' ';
    await Future.delayed(_delay, update);

    final chars = newText.split('');

    for (var i = 0; i < chars.length; i++) {
      // final start = '$currentText█';
      // final end = '$currentText${chars[i]}';

      await Future.delayed(_delay, update);
      _text = _replaceCharAt(_text, i, chars[i]);
      if (i < chars.length - 1) {
        _text = '$_text█';
      }
      await Future.delayed(_delay, update);
    }
  }

  /// Removes text
  void removeText() async {
    for (var i = _text.length - 1; i >= 0; i--) {
      _text = _replaceCharAt(_text, i, '█');
      await Future.delayed(_delay, update);

      // Remove character for next run
      _text = _removeLastChar(_text);
      // If no more charactersto remove update
      if (i == 0) {
        await Future.delayed(_delay, update);
      }
    }
  }

  /// Updates text
  Future<void> update() async {
    fn(_text);
  }
}
