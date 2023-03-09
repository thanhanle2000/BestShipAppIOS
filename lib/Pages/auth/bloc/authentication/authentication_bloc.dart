import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/repositories/user/user_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStartedEvent) {
        // Xác thực đã đăng nhập khi mới vào
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          // Nếu đã đã đăng nhập thì setState đã đăng nhập
          const name = 'Logged in';
          emit(const AuthenticationSuccess(name));
        } else {
          // setState Fail khi chưa đăng nhập
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationLoggedInEvent) {
        // Khi có sự kiện gọi check thành công thì set thẳng đã đăng nhập
        emit(const AuthenticationSuccess("name"));
      } else if (event is AuthenticationLoggedOutEvent) {
        // Đăng xuất
        _userRepository.logOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
