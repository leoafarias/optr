import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/counter.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/helpers/colors_from_string.dart';
import 'package:optr/modules/password/password.provider.dart';
import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/secret/components/secret_list.dart';
import 'package:uuid/uuid.dart';

class PasswordDetail extends HookWidget {
  /// Unique Identifier for the Account Password
  final String _id;

  /// Flags if screen is in edit state
  final bool editing;

  static const routeName = '/password-detail';

  PasswordDetail({String id})
      : _id = id ?? Uuid().v4(),
        editing = id != null;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(passwordProvider);
    final _secretProvider = useProvider(secretProvider);
    final secretList = useProvider(secretProvider.state);
    final password = useState(provider.getById(_id));
    final index = useState(0);
    final palette = useState<StringPalette>(
      colorFromString(password.value.name),
    );

    void _onClose() {
      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    }

    void save() async {
      if (password.value.masterId.isEmpty) {
        password.value.masterId = secretList[index.value].id;
      }

      final secret = _secretProvider.getById(password.value.masterId);
      secret.passwords = secret.passwords + 1;
      await password.value.save();
      await _secretProvider.add(secret);
      Navigator.pop(context);
    }

    void deleteAccount() async {
      final secret = _secretProvider.getById(password.value.masterId);
      secret.passwords = secret.passwords - 1;
      await password.value.delete();
      await _secretProvider.add(secret);
      Navigator.pop(context);
    }

    void onIndexChange(int index) {
      password.value.masterId = secretList[index].id;
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
                              editing ? password.value.name : 'Create Password',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      const OptrSpacer(),
                      OptrTextField(
                        label: 'Identifier',
                        color: palette.value.borderColor,
                        value: password.value.name,
                        onChanged: (value) {
                          password.value.name = value;
                          palette.value = colorFromString(value);
                        },
                      ),
                      const OptrSpacer(),
                      OptrTextField(
                        label: 'Website',
                        value: password.value.website,
                        color: palette.value.borderColor,
                        onChanged: (value) => password.value.website = value,
                      ),
                      const OptrSpacer(),
                      OptrCounter(
                        color: palette.value.borderColor,
                        value: password.value.version,
                        onChanged: (value) => password.value.version = value,
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
                      onTap: save,
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
