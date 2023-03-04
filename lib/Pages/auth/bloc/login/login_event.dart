part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserNameChangedEvent extends LoginEvent {
  final String username;

  const UserNameChangedEvent({required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UserNameChangedEvent { username :$username }';
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  const PasswordChangedEvent({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChangedEvent { password: $password }';
}

class LoginWithCredentialsPressedEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginWithCredentialsPressedEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressedEvent { username: $username, password: $password }';
  }
}
