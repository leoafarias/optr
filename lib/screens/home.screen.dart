import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/edges.dart';

import 'package:optr/components/spacer.dart';
import 'package:optr/modules/account/account.provider.dart';
import 'package:optr/modules/account/ui/account_list.dart';
import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/secret/ui/secret_list.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final secretList = useProvider(secretProvider.state);
    final accountList = useProvider(accountProvider.state);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OptrEdges(
            color: Colors.black,
            corners: const EdgeCorners.only(30, 30, 0, 30),
            child: Column(
              children: <Widget>[
                const OptrSpacer(),
                Row(
                  children: <Widget>[
                    const OptrSpacer(),
                    const OptrSpacer(),
                    OptrButton(
                      label: const Text('Generate Secret'),
                      onTap: () {},
                    ),
                    const OptrSpacer(),
                    OptrButton(
                      label: const Text('How To'),
                      onTap: () {},
                    ),
                  ],
                ),
                const OptrSpacer(),
                SecretList(secretList),
                Expanded(child: AccountList(accountList)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
