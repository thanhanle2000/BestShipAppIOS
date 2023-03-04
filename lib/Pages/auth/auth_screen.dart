import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/repositories/user/user_repository.dart';
import 'auth_form.dart';
import 'bloc/login/login_bloc.dart';

class AuthScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const AuthScreen({super.key, required UserRepository userRepository})
      // ignore: unnecessary_null_comparison
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: _userRepository),
      // ignore: prefer_const_constructors
      child: AuthForm(),
    );
  }
}
