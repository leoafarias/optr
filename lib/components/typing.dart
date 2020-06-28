import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/helpers/text_typing_effect.dart';

/// Increment and decrement widget
class Typing extends HookWidget {
  /// Current value of the counter
  final String data;

  /// Constructor
  const Typing(this.data);

  @override
  Widget build(BuildContext context) {
    final content = useState('');

    void typingCallback(String output) {
      content.value = output;
    }

    // ignore: missing_return
    useEffect(() {
      final typeEffect = TypingEffect(content.value, typingCallback);

      typeEffect.removeText();
    }, [data]);

    return Text(data);
  }
}
