import 'package:bank_todo/data/models/user_model.dart';
import 'package:bank_todo/redux/app_state.dart';
import 'package:bank_todo/redux/user/user_actions.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final bool isLoading;
  final bool loginError;
  final UserModel user;

  final Function(String, String) login;

  LoginViewModel({
    this.isLoading,
    this.loginError,
    this.user,
    this.login,
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      isLoading: store.state.userState.isLoading,
      loginError: store.state.userState.loginError,
      user: store.state.userState.user,
      login: (String username, String password) {
        store.dispatch(StartLoadingAction(username, password));
      },
    );
  }
}
