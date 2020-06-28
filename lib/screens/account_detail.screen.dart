import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';

import 'package:optr/components/counter.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/components/text_field.dart';

import 'package:optr/modules/account/account.provider.dart';
import 'package:uuid/uuid.dart';

class AccountDetail extends HookWidget {
  /// Unique Identifier for the Account Password
  final String _uuid;

  /// Flags if screen is in edit state
  final bool editing;

  AccountDetail({String uuid})
      : _uuid = uuid ?? Uuid().v4(),
        editing = uuid == null;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(accountProvider);
    final account = useState(provider.getById(_uuid));

    void saveAccount() async {
      if (account.value.identifier.isEmpty) {
        // TODO - Display validation error
      }
      await provider.save(account.value);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OptrEdges(
            corners: const EdgeCorners.only(25, 25, 0, 0),
            color: const Color(0xFF111111),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[
                const OptrSpacer(),
                Hero(
                  tag: 'account:title',
                  child: Text(
                    'Account Passcode',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const OptrSpacer(),
                OptrTextField(
                  label: 'Identifier',
                  value: account.value.identifier,
                  onChanged: (value) => account.value.identifier = value,
                ),
                const OptrSpacer(),
                OptrTextField(
                  label: 'Website',
                  value: account.value.website,
                  onChanged: (value) => account.value.website = value,
                ),
                const OptrSpacer(),
                OptrCounter(
                  value: account.value.version,
                  onChanged: (value) => account.value.version = value,
                ),
                const OptrSpacer(),
                const Instructions(
                  content:
                      'Instructions about something go here to explain how versions work',
                ),
                const SizedBox(height: 20),
                OptrButton.success(
                  label: const Text('Save'),
                  onTap: saveAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
