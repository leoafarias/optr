import 'package:flutter/material.dart';
import 'package:optr/components/frame.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/helpers/sound_effect.dart';
import 'package:optr/helpers/text_typing_effect.dart';

class Instructions extends HookWidget {
  final String content;
  final String title;
  final Duration duration;

  const Instructions({
    Key key,
    @required this.content,
    this.title,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = useState('');

    void _runAnimation() async {
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: unawaited_futures
      SoundEffect.play(SoundEffect.typing_long, rate: 0.8);
      TypingEffect(
        content,
        (value) => text.value = value,
        duration: duration,
      );
    }

    useEffect(() {
      _runAnimation();
      return;
    }, [content]);

    return Container(
      child: Frame(
        color: Theme.of(context).backgroundColor.withOpacity(0.6),
        lineColor: Theme.of(context).accentColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withOpacity(0.2),
            blurRadius: 3.0,
            spreadRadius: 3.0,
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title != null
                  ? Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
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
