import 'package:flutter/material.dart';
import 'package:optr/components/avatar.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/modules/word_icon/word_icon.model.dart';

/// Item that dislpays the word_icon password within the list
class WordCard extends StatelessWidget {
  /// Word model
  final WordIcon wordIcon;

  /// Constrctor for the word Item
  const WordCard({@required this.wordIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: OptrDoubleEdge(
        color: Colors.black,
        corners: const EdgeCorners.cross(0, 20),
        child: Row(
          children: <Widget>[
            OptrAvatar(name: wordIcon.word),
            const OptrSpacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  wordIcon.id,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  wordIcon.attribution,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
