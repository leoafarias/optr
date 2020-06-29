import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:optr/components/edges.dart';
import 'package:optr/components/icon_button.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/walkthrough.dart';
import 'package:optr/modules/account/account.provider.dart';
import 'package:optr/modules/account/ui/account_list.dart';
import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/secret/secret.repo.dart';
import 'package:optr/modules/secret/ui/secret_list.dart';
import 'package:optr/screens/secret_detail.screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final secretList = useProvider(secretProvider.state);
    final accountList = useProvider(accountProvider.state);

    if (secretList == null || secretList.isEmpty) {
      return const Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: WalkThorugh(),
          ),
        ),
      );
    }

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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'OPTRs',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'One Password to Rule',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Container(
                        height: 40,
                        child: OptrDoubleEdge(
                          corners: const EdgeCorners.cross(10, 0),
                          borderColor: Theme.of(context).accentColor,
                          color: Colors.black.withAlpha(230),
                          child: OptrIconButton(
                            icon: const Icon(Icons.enhanced_encryption),
                            onPressed: () {
                              // final repo = SecretRepo();
                              // repo.removeAll();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecretDetail(),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
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
