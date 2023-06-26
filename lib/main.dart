import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'Pages/auth/bloc/authentication/authentication_bloc.dart';
import 'Shared/preferences/preferences.dart';
import 'apps.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';

void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      final Iterable<CallLogEntry> cLog = await CallLog.get();
      print('Queried call log entries');
      for (CallLogEntry entry in cLog) {
        print('-------------------------------------');
        print('F. NUMBER  : ${entry.formattedNumber}');
        print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
        print('NUMBER     : ${entry.number}');
        print('NAME       : ${entry.name}');
        print('TYPE       : ${entry.callType}');
        print(
            'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
        print('DURATION   : ${entry.duration}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('SIM NAME   : ${entry.simDisplayName}');
        print('-------------------------------------');
      }
      return true;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      return true;
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  int initialThemeIndex =
      WidgetsBinding.instance.window.platformBrightness == Brightness.light
          ? 0
          : 1;

  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.themeIndexPref = Prefer.prefs?.getInt('theme') ?? initialThemeIndex;

  final UserRepository userRepository = UserRepository();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: Apps(userRepository: userRepository)));
}
