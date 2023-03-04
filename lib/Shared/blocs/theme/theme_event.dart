part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  // Passing class fields in a list to the Equatable super class
  const ThemeEvent();
}

class ThemeChangedEvent extends ThemeEvent {
  final AppTheme theme;

  const ThemeChangedEvent(this.theme);

  @override
  List<Object> get props => [theme];
}
