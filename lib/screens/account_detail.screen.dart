import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/counter.dart';
import 'package:optr/components/edges.dart';
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
        editing = id != null;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(accountProvider);
    final _secretProvider = useProvider(secretProvider);
    final secretList = useProvider(secretProvider.state);
    final account = useState(provider.getById(_id));
    final index = useState(0);
    final palette = useState<StringPalette>(
      colorFromString(account.value.identifier),
    );

    void _onClose() {
      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    }

    void saveAccount() async {
      if (account.value.masterId.isEmpty) {
        account.value.masterId = secretList[index.value].id;
      }

      final secret = _secretProvider.getById(account.value.masterId);
      secret.accountCount = secret.accountCount + 1;
      await provider.save(account.value);
      await _secretProvider.save(secret);
      Navigator.pop(context);
    }

    void deleteAccount() async {
      final secret = _secretProvider.getById(account.value.masterId);
      secret.accountCount = secret.accountCount - 1;
      await provider.remove(account.value);
      await _secretProvider.save(secret);
      Navigator.pop(context);
    }

    void onIndexChange(int index) {
      account.value.masterId = secretList[index].id;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: OptrDoubleEdge(
            corners: const EdgeCorners.only(30, 30, 0, 30),
            gradient: true,
            color: Colors.black.withOpacity(0.95),
            borderColor: palette.value.borderColor,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[
                const OptrSpacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: 'account:title',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              editing
                                  ? account.value.identifier
                                  : 'Create Password',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Secret code selected',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SecretList(
                  secretList,
                  simpleCard: true,
                  onIndexChange: onIndexChange,
                ),
                const OptrSpacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: OptrButton.active(
                    label: const Text('Copy Password'),
                    icon: Icon(Icons.content_copy),
                    onTap: () {},
                  ),
                ),
                const OptrSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OptrButton.cancel(
                      icon: Icon(Icons.arrow_back),
                      onTap: _onClose,
                    ),
                    const OptrSpacer(),
                    OptrButton.active(
                      onTap: saveAccount,
                      icon: Icon(Icons.check_circle),
                    ),
                    const OptrSpacer(),
                    editing
                        ? OptrButton.error(
                            icon: Icon(Icons.delete_forever),
                            onTap: deleteAccount,
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
