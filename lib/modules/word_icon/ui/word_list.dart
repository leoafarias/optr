import 'package:flutter/material.dart';
import 'package:optr/components/empty_dataset.dart';
import 'package:optr/modules/word_icon/ui/word_card.dart';
import 'package:optr/modules/word_icon/word_icon.model.dart';

/// List that display word_icon passwords
class WordList extends StatelessWidget {
  final List<WordIcon> _list;

  /// Creates instance of the password list
  const WordList(this._list);

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return EmptyDataset(
        message: 'No Words Were\nGenerated',
        icon: Icons.vpn_key,
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final item = _list[index];
        return WordCard(wordIcon: item);
      },
      itemCount: _list.length,
    );
  }
}
