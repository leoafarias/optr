import 'package:flutter/material.dart';

import 'package:optr/components/empty_dataset.dart';
import 'package:optr/modules/password/password.model.dart';
import 'package:optr/modules/password/components/password_item.dart';

/// List that display account passwords
class PasswordList extends StatelessWidget {
  final List<Password> list;

  /// Creates instance of the password list
  const PasswordList(this.list);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return EmptyDataset(
          message: 'No Accounts Have\n Been Added Yet', icon: Icons.vpn_key);
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return PasswordItem(list[index]);
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: list.length,
    );
  }
}
