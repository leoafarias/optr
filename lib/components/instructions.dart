import 'package:flutter/material.dart';
import 'package:optr/components/frame.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/helpers/sound_effect.dart';
import 'package:optr/helpers/text_typing_effect.dart';

class Instructions extends HookWidget {
  final String content;
  final String title;

  const Instructions({
    Key key,
    @required this.content,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = useState('');

    void _runAnimation() async {
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: unawaited_futures
      SoundEffect.play(SoundEffect.typing_long);
      TypingEffect(content, (value) => text.value = value);
    }

    useEffect(() {
      _runAnimation();
      return;
    }, [content]);

    return Container(
      child: Frame(
        color: Colors.black.withOpacity(0.6),
        lineColor: Colors.teal,
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.2),
            blurRadius: 3.0,
            spreadRadius: 3.0,
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Stack(
                // Stacks to set the height of the content
                children: <Widget>[
                  Text(text.value),
                  Opacity(
                    opacity: 0,
                    child: Text(
                      content,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
