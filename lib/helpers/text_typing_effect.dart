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

  /// Current text dislpayed
  String currentText;

  /// Scramble duration delay
  Duration delay;

  /// Constructor
  TypingEffect(this.currentText, this.fn,
      {this.delay = const Duration(milliseconds: 5)});

  /// Sets initial text
  void setText({String newText}) async {
    /// Removes text
    currentText = ' ';
    await Future.delayed(delay, update);

    final chars = newText.split('');

    for (var i = 0; i < chars.length; i++) {
      // final start = '$currentText█';
      // final end = '$currentText${chars[i]}';

      await Future.delayed(delay, update);
      currentText = _replaceCharAt(currentText, i, chars[i]);
      if (i < chars.length - 1) {
        currentText = '$currentText█';
      }
      await Future.delayed(delay, update);
    }
  }

  /// Removes text
  void removeText() async {
    for (var i = currentText.length - 1; i >= 0; i--) {
      currentText = _replaceCharAt(currentText, i, '█');
      await Future.delayed(delay, update);

      // Remove character for next run
      currentText = _removeLastChar(currentText);
      // If no more charactersto remove update
      if (i == 0) {
        await Future.delayed(delay, update);
      }
    }
    setText();
  }

  /// Updates text
  Future<void> update() async {
    fn(currentText);
  }
}
