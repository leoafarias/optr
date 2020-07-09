import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/search_field.dart';
import 'package:optr/helpers/fade_on_scroller.dart';
import 'package:optr/modules/password/components/password_item.dart';
import 'package:optr/modules/password/password.model.dart';
import 'package:optr/modules/password/password.provider.dart';

class PasswordListScreen extends HookWidget {
  PasswordListScreen();

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(passwordProvider);
    final passwords = useProvider(passwordProvider.state);
    final filteredPasswords = useState<List<Password>>([]);

    // ignore: missing_return
    useValueChanged(passwords, (_, __) {
      filteredPasswords.value = [
        ...passwords,
        ...passwords,
        ...passwords,
        ...passwords,
        ...passwords,
      ];
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            expandedHeight: 120.0,
            pinned: true,
            actions: <Widget>[Icon(Icons.add), Icon(Icons.search)],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(15),
              title: Container(
                width: double.infinity,
                child: const Text(
                  'Passwords',
                ),
              ),
              centerTitle: false,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => PasswordItem(filteredPasswords.value[index]),
              childCount: filteredPasswords.value.length,
            ),
          ),
        ],
      ),
    );
  }
}
