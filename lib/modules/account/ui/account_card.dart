import 'package:flutter/material.dart';
import 'package:optr/components/avatar.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/helpers/colors_from_string.dart';
import 'package:optr/modules/account/account.model.dart';

/// Item that dislpays the account password within the list
class AccountCard extends StatelessWidget {
  /// Account model
  final Account account;

  /// Copies to clipboard
  final Function onCopy;

  /// Constrctor for the password Item
  const AccountCard({this.account, this.onCopy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/account',
          arguments: {'id': account.id}),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: OptrDoubleEdge(
          color: Colors.black,
          corners: const EdgeCorners.cross(20, 5),
          borderColor: Theme.of(context).accentColor,
          child: Row(
            children: <Widget>[
              OptrAvatar(name: account.identifier),
              const OptrSpacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(account.identifier,
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
