import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/password/password.provider.dart';
import 'package:optr/modules/secret/secret.model.dart';

import 'package:state_notifier/state_notifier.dart';

// ignore: top_level_function_literal_block
final secretListProvider = Computed((read) {
  final passwords = read(passwordProvider.state);
  final secrets = read(secretProvider.state);

  return secrets.map<Secret>((s) {
    passwords.forEach((p) {
      if (s.id == p.secretId) s.passwords.add(p);
    });
    return s;
  }).toList();
});

///  Secret Provider
final secretProvider = StateNotifierProvider<SecretProvider>((ref) {
  return SecretProvider();
});

/// Secret Provider
class SecretProvider extends StateNotifier<List<Secret>> {
  static const boxName = 'secret';
  static var box = Hive.box<Secret>(boxName);

  SecretProvider({
    List<Secret> initialState = const [],
  }) : super(initialState) {
    init();
  }

  void init() async {
    await Hive.openBox<Secret>(boxName);
    state = box.values.toList();
  }

  Secret getById(String id) {
    return state.firstWhere((item) => item.id == id,
        orElse: () => Secret(id: id));
  }

  void save(Secret secret) async {
    await box.put(secret.id, secret);
    state = box.values.toList();
  }

  void delete(Secret secret) async {
    await box.delete(secret.id);
    state = box.values.toList();
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }
}
