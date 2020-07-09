import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/password/password.model.dart';

import 'package:optr/modules/secret/secret.provider.dart';
import 'package:state_notifier/state_notifier.dart';

// ignore: top_level_function_literal_block
final passwordListProvider = Computed((read) {
  final passwords = read(passwordProvider.state);
  final secrets = read(secretProvider.state);

  final passwordList = <PasswordWithSecret>[];

  // TODO: look into improving this
  secrets.forEach((s) {
    passwords.forEach((p) {
      if (s.id == p.secretId) {
        passwordList.add(PasswordWithSecret(p, s));
      }
    });
  });
  return passwordList;
});

/// Password Provider
final passwordProvider = StateNotifierProvider<PasswordProvider>((ref) {
  return PasswordProvider();
});

// Sort passwords
List<Password> sortPasswords(List<Password> passwords) {
  final sortedPasswords = [...passwords];
  mergeSort<Password>(sortedPasswords);
  return sortedPasswords;
}

/// AccountBloc with all state
class PasswordProvider extends StateNotifier<List<Password>> {
  static const boxName = 'password';
  static final box = Hive.box<Password>(boxName);

  PasswordProvider({
    List<Password> initialState = const [],
  }) : super(initialState) {
    init();
  }

  void init() async {
    await Hive.openBox<Password>(boxName);

    state = box.values.toList();
  }

  Password getById(String id) {
    return state.firstWhere((item) => item.id == id,
        orElse: () => Password(id: id));
  }

  /// Search Password list
  List<Password> search(String text) {
    bool startsWithQuery(Password password) {
      return password.name.toLowerCase().contains(text);
    }

    return state.where(startsWithQuery).toList();
  }

  void save(Password password) async {
    await box.put(password.id, password);
    state = box.values.toList();
  }

  void delete(Password password) async {
    await box.delete(password.id);
    state = box.values.toList();
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }
}
