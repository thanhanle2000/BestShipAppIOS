import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../preferences/preferences.dart';
import 'app_theme.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, AppTheme> {
  ThemeBloc() : super(AppTheme.values[Prefer.themeIndexPref]);

  Stream<AppTheme> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChangedEvent) {
      yield event.theme;
      Prefer.prefs = await SharedPreferences.getInstance();
      Prefer.prefs?.setInt('theme', event.theme.index);
    }
  }
}
