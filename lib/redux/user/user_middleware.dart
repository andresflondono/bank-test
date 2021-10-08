import 'package:bank_todo/data/models/user_model.dart';
import 'package:bank_todo/data/networking/api.dart';
import 'package:bank_todo/redux/app_state.dart';
import 'package:bank_todo/redux/user/user_actions.dart';
import 'package:redux/redux.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {
  LoginMiddleware(this.api);

  final API api;

  @override
  Future<void> call(
      Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);
    if (action is StartLoadingAction) {
      return _loginUser(next, action, store); //_loginUser(next, action, store);
    } else {
      if (action is UpdateUserInfo) {
        return _updateUser(next, action, store);
      }
    }
  }

  Future _loginUser(
      NextDispatcher next, dynamic action, Store<AppState> store) async {
    return Future(() async {
      api.login(action.email, action.password).then((firebaseResponse) {
        if (firebaseResponse['user'] != null) {
          Map<String, dynamic> firebaseUser = {
            "email": firebaseResponse['user'].email,
            "token": firebaseResponse['token'],
            "id": firebaseResponse['user'].uid
          };

          api.getUserInfo().then((userResponse) {
            final user = userResponse.value;
            print(user);
            if (user != null) {
              store.dispatch(new LoginSuccessAction(UserModel.fromJson({}
                ..addAll(firebaseUser)
                ..addAll(new Map<String, dynamic>.from(user)))));
            } else {
              store.dispatch(new LoginFailedAction());
            }
          }, onError: (error) {
            store.dispatch(new LoginFailedAction());
          });
        } else {
          store.dispatch(new LoginFailedAction());
        }
        //Keys.navKey.currentState.pushNamed('/'); Change screen
      }, onError: (error) {
        print(error);
        store.dispatch(new LoginFailedAction());
      });
    });
  }

  Future _updateUser(
      NextDispatcher next, dynamic action, Store<AppState> store) async {
    return Future(() async {
      api.getUserInfo().then((userResponse) async {
        final user = userResponse.value;
        if (user != null) {
          await store.dispatch(new LoginSuccessAction(UserModel.fromJson({}
            ..addAll(action.user.toJson())
            ..addAll(new Map<String, dynamic>.from(user)))));
          action.completer.completer.complete();
        } else {
          store.dispatch(new LoginFailedAction());
          action.completer.completer.complete();
        }
      }, onError: (error) {
        store.dispatch(new LoginFailedAction());
        action.completer.completer.complete();
      });
    });
  }
}
