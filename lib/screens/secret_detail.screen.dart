import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/display_button.dart';
import 'package:optr/components/empty_space.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/password_strength.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/helpers/generate_optr.dart';

import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/word_icon/word_icon.repo.dart';
import 'package:uuid/uuid.dart';
import 'package:xcvbnm/xcvbnm.dart';

final xcvbm = Xcvbnm();

class SecretDetail extends HookWidget {
  /// Unique Identifier for the Account Password
  final String _uuid;

  /// Flags if screen is in edit state
  final bool editing;

  static String routeName = '/secret-detail';

  SecretDetail({String uuid})
      : _uuid = uuid ?? Uuid().v4(),
        editing = uuid != null;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(secretProvider);
    final secret = useState(provider.getById(_uuid));

    final passphrase = useState('');
    final result = useState<Result>();
    final hash = useState(editing ? secret.value.hash : '**** **** **** ****');
    final icons = useState<List<Uint8List>>();

    useValueChanged(passphrase.value, (_, __) async {
      secret.value.hash = await hashSecret(passphrase.value);
      result.value = xcvbm.estimate(passphrase.value);
    });

    void onClose() {
      Navigator.pop(context);
    }

    void onSave() {
      if (secret.value.name.isEmpty) {
        // TODO - Display validation error
      }
      provider.save(secret.value);
      onClose();
    }

    void onDelete() {
      provider.delete(secret.value);
      onClose();
    }

    void onGenerate() {
      final words = WordIconRepo.generate();
      final phrase = words.map((w) => w.word).join(' ');

      final iconList = words.map((w) => w.image).toList();
      icons.value = iconList;
      passphrase.value = phrase;
      passphrase.value;
    }

    Widget renderDeleteButton() {
      return Expanded(
        child: OptrButton(
          label: 'Delete',
          onPressed: onDelete,
          icon: Icons.delete,
          color: Colors.red,
        ),
      );
    }

    Widget renderSaveButton() {
      return Expanded(
        child: OptrButton(
          label: 'Save',
          onPressed: onSave,
          icon: Icons.check_circle,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Secret'),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            renderSaveButton(),
            const OptrSpacer(),
            editing ? renderDeleteButton() : Empty,
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: <Widget>[
            const OptrSpacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  const OptrSpacer(),
                  OptrTextField(
                    label: 'Label',
                    autofocus: true,
                    color: Theme.of(context).accentColor,
                    value: secret.value.name,
                    onChanged: (value) {
                      secret.value.name = value;
                    },
                  ),
                  !editing
                      ? Column(
                          children: <Widget>[
                            const OptrSpacer(),
                            const Instructions(
                              content:
                                  'We can help you generate an fully random secure easy to remember passphrase.',
                            ),
                            Container(
                              width: double.infinity,
                              child: OptrDisplayButton.active(
                                label: const Text('Generate a passphrase'),
                                icon: Icon(Icons.vpn_key),
                                onTap: onGenerate,
                              ),
                            ),
                            const OptrSpacer(),
                            OptrTextField(
                              label: 'Passphrase',
                              value: passphrase.value,
                              color: Theme.of(context).accentColor,
                              onChanged: (value) => passphrase.value = value,
                            ),
                            const OptrSpacer(),
                            PasswordStrengthDisplay(result.value)
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  // TODO:
                  const SizedBox(height: 20),
                  icons.value != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: icons.value.map((icon) {
                            return SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.memory(
                                icon,
                                color: Theme.of(context).accentColor,
                              ),
                            );
                          }).toList(),
                        )
                      : const SizedBox(),
                  const OptrSpacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
