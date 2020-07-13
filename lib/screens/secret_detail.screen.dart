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
import 'package:optr/helpers/seconds_to_readable.dart';

import 'package:optr/modules/secret/secret.provider.dart';
import 'package:optr/modules/word_icon/word_icon.repo.dart';
import 'package:uuid/uuid.dart';
import 'package:xcvbnm/xcvbnm.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

    void save() {
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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: OptrDoubleEdge(
            corners: const EdgeCorners.only(30, 30, 0, 30),
            color: Theme.of(context).cardColor,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Generate Secret',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
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
                                result.value != null
                                    ? LinearPercentIndicator(
                                        // width: 140.0,
                                        lineHeight: 14.0,
                                        percent: result.value.score * 0.25,
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        progressColor:
                                            Theme.of(context).accentColor,
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Text(convertSecondsToReadable(result.value?.crackTime)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OptrButton.active(
                      icon: Icon(Icons.check_circle),
                      onTap: save,
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
