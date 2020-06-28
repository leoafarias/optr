import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/secret/secret.repo.dart';
import 'package:optr/modules/secret/ui/secret_list.dart';
import 'package:optr/screens/secret_detail.screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final secretList = useProvider(secretProvider.state);
    final secretRepo = useProvider(secretRepoProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              OptrButton(
                label: 'Generate',
                icon: Icons.add,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecretDetail(),
                    ),
                  );
                },
              ),
              OptrButton(
                  label: 'Reset Master Secrets',
                  icon: Icons.delete,
                  onTap: () {
                    secretRepo.removeAll();
                  }),
              const OptrSpacer(),
              SecretList(secretList),
            ],
          ),
        ),
      ),
    );
  }
}
