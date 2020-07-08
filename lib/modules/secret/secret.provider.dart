import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/secret/secret.model.dart';

import 'package:state_notifier/state_notifier.dart';

///  Secret Provider
final secretProvider = StateNotifierProvider<SecretProvider>((ref) {
  return SecretProvider();
});

/// Secret Provider
class SecretProvider extends StateNotifier<List<Secret>> {
  static const boxName = 'password';
  static final box = Hive.box<Secret>(boxName);

  SecretProvider({
    List<Secret> initialState = const [],
  }) : super(initialState) {
    init();
  }

  void init() async {
    await Hive.openBox<Secret>(boxName);
    box.watch().listen((_) {
      state = [...box.values];
    });
  }

  Secret getById(String id) {
    return state.firstWhere(
      (item) => item.id == id,
      orElse: () => Secret(id: id),
    );
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }
}
