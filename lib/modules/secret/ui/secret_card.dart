import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/spacer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/helpers/sound_effect.dart';
import 'package:optr/helpers/text_decoder_effect.dart';
import 'package:optr/helpers/text_typing_effect.dart';
import 'package:optr/modules/secret/secret.model.dart';

/// Tile for the Master Secret List
class SecretCard extends HookWidget {
  final Secret _secret;

  final Function _onPressed;

  final bool active;

  /// Creates instance of Master Secret Tile
  const SecretCard({
    Key key,
    @required Secret secret,
    @required Function onPressed,
    this.active = false,
  })  : _secret = secret,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final countText = useState('');
    final secretLabel = useState('');
    final labelText = useState('');

    String accountsCountText;
    final accountCount = _secret.accountCount;

    if (accountCount == null || accountCount == 0) {
      accountsCountText = 'No passwords generated with secret.';
    } else if (_secret.accountCount == 1) {
      accountsCountText = '$accountCount passwords generated.';
    } else {
      accountsCountText = '$accountCount passwords generated.';
    }

    void _runAnimation() async {
      // ignore: unawaited_futures
      try {
        // TextDecoder(accountsCountText, (value) => countText.value = value);
        TypingEffect(accountsCountText, (value) => countText.value = value);
        TextDecoder(_secret.label, (value) => secretLabel.value = value);
        TextDecoder('MASTER SECRET_ Label', (value) => labelText.value = value);
      } on Exception {
        // Switching cards, disposes
        // Need to catch exception
        print('ValueNotifier was used after being disposed');
      }
    }

    useEffect(() {
      if (active) _runAnimation();
      return;
    }, [active]);

    return GestureDetector(
      key: key,
      onTap: _onPressed,
      child: OptrDoubleEdge(
        corners: const EdgeCorners.all(15),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(
                color: Colors.teal,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(labelText.value,
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(secretLabel.value.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              const Divider(
                color: Colors.teal,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OptrDoubleEdge(
                      borderColor: Colors.teal,
                      color: Colors.black.withAlpha(230),
                      corners: const EdgeCorners.only(0, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          countText.value,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}