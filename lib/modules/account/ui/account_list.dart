import 'package:flutter/material.dart';

import 'package:optr/components/empty_dataset.dart';
import 'package:optr/modules/account/account.model.dart';
import 'package:optr/modules/account/ui/account_card.dart';

/// List that display account passwords
class AccountList extends StatelessWidget {
  final List<Account> _list;

  /// Creates instance of the password list
  const AccountList(this._list);

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return EmptyDataset(
          message: 'No Accounts Have\n Been Added Yet', icon: Icons.vpn_key);
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final item = _list[index];
        return AccountCard(
          account: item,
        );
      },
      itemCount: _list.length,
    );
  }
}
