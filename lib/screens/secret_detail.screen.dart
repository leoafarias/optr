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
        editing = uuid == null;

  /// Route of the screen to be used for navigation
  static const String routeName = 'secret-detail';

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(secretProvider);
    final secret = useState(provider.getById(_uuid));
    final passphrase = useState('');

    useValueChanged(passphrase.value, (_, __) async {
      secret.value.hash = await generateOptr(passphrase.value, '');
    });

    void saveSecret() async {
      if (secret.value.name.isEmpty) {
        // TODO - Display validation error
      }
      await provider.save(secret.value);
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
              children: <Widget>[
                const OptrSpacer(),
                Text(
                  'Create Optr',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const OptrSpacer(),
                const Instructions(
                  content:
                      'Optr (One Password to Rule): Is a hashed passphrase which allows you to retrieve any account passwords from memory.',
                ),
                const OptrSpacer(),
                OptrTextField(
                  label: 'Name',
                  value: secret.value.name,
                  onChanged: (value) => secret.value.name = value,
                ),
                const OptrSpacer(),
                OptrTextField(
                  label: 'Passphrase',
                  obscureText: true,
                  value: passphrase.value,
                  onChanged: (value) => passphrase.value = value,
                ),
                const OptrSpacer(),
                Text(secret.value.hash),
                const OptrSpacer(),
                OptrButton.success(label: 'Save', onTap: saveSecret),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
