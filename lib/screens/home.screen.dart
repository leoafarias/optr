import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/typography.dart';
import 'package:optr/modules/password/components/password_list.dart';
import 'package:optr/modules/password/password.model.dart';
import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/secret/components/secret_list.dart';
import 'package:optr/screens/password_detail_screen.dart';
import 'package:optr/screens/secret_detail.screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final secretList = useProvider(secretListProvider);
    final currentIndex = useState<int>(0);
    final activePasswords = useState<List<Password>>();

    useValueChanged(currentIndex.value, (_, __) {
      activePasswords.value = [];
      Timer timer;
      timer = Timer(const Duration(milliseconds: 0), () {
        activePasswords.value = secretList[currentIndex.value].passwords;
        timer.cancel();
      });
    });

    final activeSecret =
        secretList.isNotEmpty ? secretList[currentIndex.value] : null;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const OptrTitle('Secrets'),
                  OutlineButton.icon(
                    label: const Text('Generate'),
                    icon: const Icon(Icons.add_box),
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
                ],
              ),
              SecretList(
                secretList,
                onIndexChange: (index) {
                  currentIndex.value = index;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const OptrTitle('Passwords'),
                  OutlineButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordDetail(),
                        ),
                      );
                    },
                    icon: Icon(Icons.create_new_folder),
                    label: Text('Add to ${activeSecret?.name}'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: PasswordList(activePasswords.value)),
            ],
          ),
        ),
      ),
    );
  }
}
