import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Shared/models/auth/auth_models.dart';
import '../../../../Shared/preferences/preferences.dart';
import '../../../../Shared/utils/validators.dart';
import '../../../../presentation/repositories/user/user_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.empty()) {
    on<LoginEvent>((event, emit) async {
      if (event is UserNameChangedEvent) {
        emit(state.update(
          isValid: Validators.isValid(event.username),
        ));
      } else if (event is PasswordChangedEvent) {
        emit(state.update(
          isPasswordValid: Validators.isValid(event.password),
        ));
      } else if (event is LoginWithCredentialsPressedEvent) {
        emit(LoginState.loading());
        try {
          final AuthModels auth = await _userRepository.loginWithCredentials(
              event.username, event.password);
          if (auth.successful == true) {
            storeUserData(auth.token!, auth.authenticationViewModel!);
            emit(LoginState.success());
          } else {
            emit(LoginState.failure(auth.error.toString()));
          }
        } catch (_) {
          emit(LoginState.failure("Vui lòng kiểm tra lại kết nối."));
        }
      }
    });
  }

  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) {
      return (event is! UserNameChangedEvent && event is! PasswordChangedEvent);
    });

    final debounceStream = events.where((event) {
      return (event is UserNameChangedEvent || event is PasswordChangedEvent);
    }).debounceTime(const Duration(milliseconds: 300));

    return MergeStream([debounceStream, nonDebounceStream])
        .flatMap(transitionFn);
  }

  // lưu trữ dữ liệu user login
  void storeUserData(
      String token, AuthenticationViewModel authenticationViewModel) async {
    Prefer.prefs = await SharedPreferences.getInstance();
    Prefer.prefs!.setString('token', token);
    String authenticationViewModelJson = jsonEncode(authenticationViewModel);
    Prefer.prefs!
        .setString('authenticationViewModel', authenticationViewModelJson);
  }
}
