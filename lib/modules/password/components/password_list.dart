import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    if (list == null || list.isEmpty) {
      return EmptyDataset(
          message: 'No Accounts Have\n Been Added Yet', icon: Icons.vpn_key);
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 200),
          child: FadeInAnimation(
            child: PasswordItem(list[index]),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: list.length,
    );
  }
}
