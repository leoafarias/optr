import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/helpers/generate_optr.dart';

import 'package:optr/modules/secret/secret.provider.dart';
import 'package:uuid/uuid.dart';

class SecretDetail extends HookWidget {
  /// Unique Identifier for the Account Password
  final String _uuid;

  /// Flags if screen is in edit state
  final bool editing;

  SecretDetail({String uuid})
      : _uuid = uuid ?? Uuid().v4(),
        editing = uuid != null;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(secretProvider);
    final secret = useState(provider.getById(_uuid));
    final label = useState(
      editing ? secret.value.label : 'Add a Secret Code',
    );
    final passphrase = useState('');

    useValueChanged(passphrase.value, (_, __) async {
      secret.value.hash = await generateOptr(passphrase.value, '');
    });

    void saveSecret() async {
      if (secret.value.label.isEmpty) {
        // TODO - Display validation error
      }
      await provider.save(secret.value);
    }

    void onClose() {
      Navigator.pop(context);
    }

    void onGenerate() {}

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: OptrDoubleEdge(
            corners: const EdgeCorners.only(30, 30, 0, 30),
            gradient: true,
            color: Colors.black.withOpacity(0.95),
            borderColor: Theme.of(context).accentColor,
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
                        tag: 'secret:name',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              label.value,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      const OptrSpacer(),
                      OptrTextField(
                        label: 'Label',
                        autofocus: true,
                        color: Theme.of(context).accentColor,
                        value: secret.value.label,
                        onChanged: (value) {
                          secret.value.label = value;
                          // Updates the label display also
                          label.value = value;
                        },
                      ),
                      const OptrSpacer(),
                      OptrTextField(
                        label: 'Secret code',
                        value: passphrase.value,
                        color: Theme.of(context).accentColor,
                        onChanged: (value) => passphrase.value = value,
                      ),
                      const OptrSpacer(),
                      OptrButton.active(
                        label: const Text('Generate a passphrase for me.'),
                        icon: Icon(Icons.vpn_key),
                        onTap: onGenerate,
                      ),
                      const OptrSpacer(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OptrButton.active(
                      label: const Text('Save'),
                      icon: Icon(Icons.check_circle),
                      onTap: saveSecret,
                    ),
                    const OptrSpacer(),
                    OptrButton.cancel(
                      label: const Text('Cancel'),
                      icon: Icon(Icons.cancel),
                      onTap: onClose,
                    ),
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
