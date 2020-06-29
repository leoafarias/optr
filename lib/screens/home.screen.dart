import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/instructions.dart';

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
          child: OptrDoubleEdge(
            color: Theme.of(context).cardColor,
            corners: const EdgeCorners.only(30, 30, 0, 30),
            child: Column(
              children: <Widget>[
                // Row(
                //   children: <Widget>[
                //     const OptrSpacer(),
                //     const OptrSpacer(),
                //     OptrButton(
                //       label: const Text('Generate Secret'),
                //       onTap: () {},
                //     ),
                //     const OptrSpacer(),
                //     OptrButton(
                //       label: const Text('How To'),
                //       onTap: () {},
                //     ),
                //   ],
                // ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 30),
                    Text(
                      'OPTRs',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                SecretList(secretList),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Instructions(
                      content:
                          'You can create hacker safe passwords by choosing a secret you would liket o use'),
                ),
                Expanded(child: AccountList(accountList)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
