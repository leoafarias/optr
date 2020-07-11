import 'package:flutter/material.dart';
import 'package:optr/components/edges.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/components/typography.dart';
import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/screens/secret_detail.screen.dart';
import 'package:vizor/components/atoms/text_decoding/text_decoding.dart';

/// Tile for the Master Secret List
class SecretCard extends HookWidget {
  final Secret secret;

  final bool active;
  final String labelRedacted = '████';
  final String countRedacted = '███████';

  /// Creates instance of Master Secret Tile
  SecretCard({
    @required this.secret,
    this.active = false,
  }) : super(key: Key(secret.id));

  @override
  Widget build(BuildContext context) {
    String accountsCountText;
    final accountCount = secret.passwords.length;

    if (accountCount == null || accountCount == 0) {
      accountsCountText = 'No passwords';
    } else if (accountCount == 1) {
      accountsCountText = '$accountCount password';
    } else {
      accountsCountText = '$accountCount passwords';
    }

    String redactName(String name) {
      if (name == null || name.isEmpty) return labelRedacted;
      return '${name[0]} $labelRedacted';
    }

    return GestureDetector(
      key: key,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecretDetail(uuid: secret.id),
          ),
        );
      },
      child: OptrDoubleEdge(
        corners: const EdgeCorners.all(10),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextDecoding(
                active ? secret.name.toUpperCase() : redactName(secret.name),
                shouldDecode: active,
                style: OptrTitle.style(context),
              ),
              TextDecoding(
                active ? accountsCountText : countRedacted,
                shouldDecode: active,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
