import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/account/account.model.dart';
import 'package:optr/modules/account/account.repo.dart';
import 'package:state_notifier/state_notifier.dart';

/// Account List
final accountList = FutureProvider<List<Account>>((ref) async {
  final repo = ref.read(accountRepoProvider).value;
  final list = await repo.getAll();
  return list;
});

/// Master Secret Provider
final accountProvider = StateNotifierProvider<AccountProvider>((ref) {
  final provider = AccountProvider([]);
  provider.setInitialState(ref.read(accountList).future);
  return provider;
});

/// AccountBloc with all state
class AccountProvider extends StateNotifier<List<Account>> {
  final _repo = AccountRepo();

  /// Constructor
  AccountProvider(List<Account> initialState) : super(initialState ?? []);

  /// Sets initial state

  void setInitialState(Future<List<Account>> initialState) async {
    final list = await initialState;
    state = [...list];
  }

  /// Get Account by Id
  //TODO: Should move this to base Provider
  Account getById(String id) {
    return state.firstWhere(
      (item) => item.id == id,
      orElse: () => Account(id: id),
    );
  }

  /// Add a new account to list
  Future<void> save(Account account) async {
    await remove(account);
    state = [...state, account];

    await _repo.save(account);
  }

  /// Removes an account from list
  Future<void> remove(Account model) async {
    state = state.where((item) => item.id != model.id).toList();
    await _repo.remove(model);
  }
}
