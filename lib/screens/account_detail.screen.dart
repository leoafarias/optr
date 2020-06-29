import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';

import 'package:optr/components/counter.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/helpers/colors_from_string.dart';

import 'package:optr/modules/account/account.provider.dart';
import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/secret/ui/secret_list.dart';
import 'package:uuid/uuid.dart';

class AccountDetail extends HookWidget {
  /// Unique Identifier for the Account Password
  final String _id;

  /// Flags if screen is in edit state
  final bool editing;

  static const routeName = '/account';

  AccountDetail({String id})
      : _id = id ?? Uuid().v4(),
        editing = id == null;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(accountProvider);
    final secretList = useProvider(secretProvider.state);
    final account = useState(provider.getById(_id));
    final palette = useState<StringPalette>(
      colorFromString(account.value.identifier),
    );

    void _onClose() {
      FocusScope.of(context).unfocus();
      Navigator.pop(context, false);
    }

    void saveAccount() async {
      if (account.value.identifier.isEmpty) {
        // TODO - Display validation error
      }
      await provider.save(account.value);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: OptrDoubleEdge(
            corners: const EdgeCorners.only(30, 30, 0, 30),
            color: Colors.black.withOpacity(0.95),
            borderColor: palette.value.borderColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                    color: palette.value.borderColor,
                    value: account.value.identifier,
                    onChanged: (value) {
                      account.value.identifier = value;
                      palette.value = colorFromString(value);
                    },
                  ),
                  const OptrSpacer(),
                  OptrTextField(
                    label: 'Website',
                    value: account.value.website,
                    color: palette.value.borderColor,
                    onChanged: (value) => account.value.website = value,
                  ),
                  const OptrSpacer(),
                  OptrCounter(
                    color: palette.value.borderColor,
                    value: account.value.version,
                    onChanged: (value) => account.value.version = value,
                  ),
                  const OptrSpacer(),
                  const SizedBox(height: 20),
                  SecretList(secretList),
                  Row(
                    children: <Widget>[
                      OptrButton.success(
                        label: const Text('Save'),
                        onTap: saveAccount,
                      ),
                      const OptrSpacer(),
                      OptrButton.error(
                        label: const Text('Cancel'),
                        onTap: _onClose,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
