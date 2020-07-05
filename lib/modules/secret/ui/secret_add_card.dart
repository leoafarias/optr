import 'package:flutter/material.dart';

import 'package:optr/components/button.dart';
import 'package:optr/components/edges.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/screens/secret_detail.screen.dart';

/// Tile for the Master Secret List
class SecretAddCard extends HookWidget {
  final bool active;

  /// Creates instance of Master Secret Tile
  const SecretAddCard({
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

    return GestureDetector(
      key: key,
      onTap: onPress,
      child: OptrDoubleEdge(
        corners: const EdgeCorners.all(15),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                OptrButton.active(
                  label: const Text('Generate a Secret Code'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
