import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/auth/bloc/authentication/authentication_bloc.dart';
import 'Shared/preferences/preferences.dart';
import 'apps.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  int initialThemeIndex =
      WidgetsBinding.instance.window.platformBrightness == Brightness.light
          ? 0
          : 1;

  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.themeIndexPref = Prefer.prefs?.getInt('theme') ?? initialThemeIndex;

  final UserRepository userRepository = UserRepository();

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: Apps(userRepository: userRepository)));
}
