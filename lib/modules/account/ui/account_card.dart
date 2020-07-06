import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:optr/components/avatar.dart';

import 'package:optr/components/icon_button.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/helpers/colors_from_string.dart';
import 'package:optr/modules/account/account.model.dart';
import 'package:optr/screens/account_detail.screen.dart';

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
    return OpenContainer(
      tappable: true,
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 100),
      closedBuilder: (context, action) => _buildContainer(context),
      openBuilder: (context, action) => AccountDetail(id: account.id),
    );
  }

  Widget WebsiteLabel(BuildContext context, String website) {
    if (website == null || website.isEmpty) {
      return const SizedBox();
    }

    return Text(
      account.website,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    final palette = colorFromString(account.identifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: <Widget>[
          OptrAvatar(account.identifier),
          const OptrSpacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                account.identifier,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              WebsiteLabel(context, account.website),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          OptrIconButton(
            icon: Icon(
              Icons.content_copy,
              color: Colors.white.withOpacity(0.3),
            ),
            color: palette.borderColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
