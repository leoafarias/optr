import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/modules/secret/secret.repo.dart';
import 'package:state_notifier/state_notifier.dart';

/// Master Secret List
final secretList = FutureProvider<List<Secret>>((ref) async {
  final repo = ref.read(secretRepoProvider).value;
  return await repo.getAll();
});

/// Master Secret Provider
final secretProvider = StateNotifierProvider<SecretProvider>((ref) {
  final provider = SecretProvider([]);
  provider.setInitialState(ref.read(secretList).future);
  return provider;
});

/// MasterSecretList  all state
class SecretProvider extends StateNotifier<List<Secret>> {
  final _repo = SecretRepo();

  /// Constructor
  SecretProvider(List<Secret> initialState) : super(initialState ?? []);

  /// Sets initial state

  void setInitialState(Future<List<Secret>> initialState) async {
    final list = await initialState;
    state = [...list];
  }

  /// Get Account by Id
  //TODO: Should move this to base Provider
  Secret getById(String id) {
    return state.firstWhere(
      (item) => item.id == id,
      orElse: () => Secret(id: id),
    );
  }

  /// Add a new account to list
  Future<void> save(Secret secret) async {
    await remove(secret);
    state = [...state, secret];
    await _repo.save(secret);
  }

  /// Removes an account from list
  Future<void> remove(Secret model) async {
    state = state.where((item) => item.id != model.id).toList();
    await _repo.remove(model);
  }
}
