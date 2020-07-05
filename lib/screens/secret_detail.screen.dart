import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/instructions.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/helpers/generate_optr.dart';
import 'package:optr/helpers/text_decoder_effect.dart';

import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/word_icon/word_icon.repo.dart';
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
      editing ? secret.value.label : 'Generate Hash',
    );
    final passphrase = useState('');
    final hash = useState(editing ? secret.value.hash : '**** **** **** ****');
    final icons = useState<List<Uint8List>>();

    void decodeCallback(String value) {
      hash.value = value;
    }

    useValueChanged(passphrase.value, (_, __) async {
      secret.value.hash = await generateOptr(passphrase.value);
      TextDecoder(secret.value.hash, decodeCallback);
    });

    void saveSecret() async {
      if (secret.value.label.isEmpty) {
        // TODO - Display validation error
      }
      await provider.save(secret.value);
      Navigator.pop(context);
    }

    void onClose() {
      Navigator.pop(context);
    }

    void onDelete() async {
      await provider.remove(secret.value);
    }

    void onGenerate() {
      final words = WordIconRepo.generate();
      final phrase = words.map((w) => w.word).join(' ');

      final iconList = words.map((w) => w.image).toList();
      icons.value = iconList;
      passphrase.value = phrase;
      passphrase.value;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: OptrDoubleEdge(
            corners: const EdgeCorners.only(30, 30, 0, 30),
            gradient: true,
            color: Colors.black.withAlpha(230),
            borderColor: Colors.deepPurpleAccent,
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      !editing
                          ? Column(
                              children: <Widget>[
                                const OptrSpacer(),
                                const Instructions(
                                    content:
                                        'We can help you generate an fully random secure easy to remember passphrase.'),
                                Container(
                                  width: double.infinity,
                                  child: OptrButton.active(
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
                                  onChanged: (value) =>
                                      passphrase.value = value,
                                ),
                                const OptrSpacer(),
                              ],
                            )
                          : const SizedBox(),
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
                      OptrDoubleEdge(
                        color: Theme.of(context).cardColor,
                        corners: const EdgeCorners.cross(10, 0),
                        borderColor: Theme.of(context).accentColor,
                        child: SizedBox(
                            height: 80,
                            child: Center(
                                child: Text(
                              hash.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white),
                            ))),
                      ),
                      const OptrSpacer(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OptrButton.active(
                      icon: Icon(Icons.check_circle),
                      onTap: saveSecret,
                    ),
                    const OptrSpacer(),
                    OptrButton.cancel(
                      icon: Icon(Icons.cancel),
                      onTap: onClose,
                    ),
                    const OptrSpacer(),
                    editing
                        ? OptrButton.error(
                            icon: Icon(Icons.delete_forever),
                            onTap: onDelete,
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
