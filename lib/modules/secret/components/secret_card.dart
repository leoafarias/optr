import 'package:flutter/material.dart';
import 'package:optr/components/edges.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/screens/secret_detail.screen.dart';
import 'package:vizor/components/atoms/text_decoding/text_decoding.dart';

/// Tile for the Master Secret List
class SecretCard extends HookWidget {
  final Secret _secret;

  final bool active;

  /// Simple card style
  final bool simpleCard;

  /// Creates instance of Master Secret Tile
  const SecretCard({
    Key key,
    @required Secret secret,
    this.simpleCard = false,
    this.active = false,
  })  : _secret = secret,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String accountsCountText;
    final accountCount = _secret.passwords;

    if (accountCount == null || accountCount == 0) {
      accountsCountText = 'No passwords';
    } else if (_secret.passwords == 1) {
      accountsCountText = '$accountCount password';
    } else {
      accountsCountText = '$accountCount passwords';
    }

    return GestureDetector(
      key: key,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecretDetail(uuid: _secret.id),
          ),
        );
      },
      child: OptrDoubleEdge(
        corners: const EdgeCorners.all(10),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextDecoding(
                    _secret.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextDecoding(accountsCountText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
