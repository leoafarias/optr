import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
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
    void onPress() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecretDetail(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const OptrSpacer(),
          Instructions(
            title: 'Hi, Welcome!',
            content:
                'Is it possible to create of easy to remember, hard to guess secure deterministic passwords framework. Do we have the ability to recover all of our passwords from memory?',
            duration: const Duration(seconds: 3),
          ),
        ],
      ),
    );
  }
}
