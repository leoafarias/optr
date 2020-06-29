import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/screens/secret_detail.screen.dart';

/// Tile for the Master Secret List
class WalkThorugh extends HookWidget {
  final bool active;

  /// Creates instance of Master Secret Tile
  const WalkThorugh({
    Key key,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showNext = useState(false);

    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () => showNext.value = true);
      return;
    });

    void onPress() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecretDetail(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const OptrSpacer(),
            const Instructions(
              title: 'Hi, Welcome!',
              content:
                  '\nAre you ready for password freedom?  This is the first step to create easy to remember, impossible to guess unique passwords.\n\nHow would you feel if you could recover all your credentials from memory?\n\n Well.. all that is possible. I will see you on the other side.\n',
              duration: Duration(seconds: 5),
            ),
            const OptrSpacer(),
            showNext.value
                ? OptrButton.active(
                    label: const Text('Next '),
                    icon: Icon(Icons.arrow_forward),
                    onTap: onPress,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
