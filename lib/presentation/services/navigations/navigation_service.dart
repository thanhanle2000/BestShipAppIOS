import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationTransition {
  static const String Fade = 'fade';
  static const String RightToLeft = 'righttoleft';
  static const String LeftToRight = 'lefttoright';
  static const String UpToDown = 'uptodown';
  static const String DownToUp = 'downtoup';
  static const String RightToLeftWithFade = 'righttoleftwithfade';
  static const String LeftToRighttWithFade = 'lefttorightwithfade';
}

/// Provides a service that can be injected into the ViewModels for navigation.
///
/// Uses the Get library for all navigation requirements
class NavigationService {
  Map<String, Transition> _transitions = {
    NavigationTransition.Fade: Transition.fade,
    NavigationTransition.RightToLeft: Transition.rightToLeft,
    NavigationTransition.LeftToRight: Transition.leftToRight,
    NavigationTransition.UpToDown: Transition.upToDown,
    NavigationTransition.DownToUp: Transition.downToUp,
    NavigationTransition.RightToLeftWithFade: Transition.rightToLeftWithFade,
    NavigationTransition.LeftToRighttWithFade: Transition.leftToRightWithFade,
  };

  GlobalKey<NavigatorState> get navigatorKey {
    return Get.key;
  }

  /// Allows you to configure the default behaviour for navigation.
  ///
  /// [defaultTransition] can be set using the static members of [NavigationTransition]
  ///
  /// If you want to use the string directly. Defined [transition] values are
  /// - fade
  /// - rightToLeft
  /// - leftToRight
  /// - upToDown
  /// - downToUp
  /// - scale
  /// - rotate
  /// - size
  /// - rightToLeftWithFade
  /// - leftToRightWithFade
  /// - cupertino
  void config(
      {bool? enableLog,
      bool? defaultPopGesture,
      bool? defaultOpaqueRoute,
      Duration? defaultDurationTransition,
      bool? defaultGlobalState,
      String? defaultTransition}) {
    Get.config(
        enableLog: enableLog,
        defaultPopGesture: defaultPopGesture,
        defaultOpaqueRoute: defaultOpaqueRoute,
        defaultDurationTransition: defaultDurationTransition,
        defaultGlobalState: defaultGlobalState,
        defaultTransition: _getTransitionOrDefault(defaultTransition!));
  }

  /// Pushes [page] onto the navigation stack. This uses the [page] itself (Widget) instead
  /// of routeName (String).
  ///
  /// Defined [transition] values can be accessed as static memebers of [NavigationTransition]
  ///
  /// If you want to use the string directly. Defined [transition] values are
  /// - fade
  /// - rightToLeft
  /// - leftToRight
  /// - upToDown
  /// - downToUp
  /// - scale
  /// - rotate
  /// - size
  /// - rightToLeftWithFade
  /// - leftToRightWithFade
  /// - cupertino
  Future<dynamic>? navigateWithTransition(Widget page,
      {bool? opaque,
      String? transition,
      Duration? duration,
      bool? popGesture}) {
    return Get.to(
      page,
      transition: _getTransitionOrDefault(transition!),
      duration: duration, //defaultDurationTransition
      popGesture: popGesture ?? Get.isPopGestureEnable,
      opaque: opaque ?? Get.isOpaqueRouteDefault,
    );
  }

  /// Replaces current view in the navigation stack. This uses the [page] itself (Widget) instead
  /// of routeName (String).
  ///
  /// Defined [transition] values can be accessed as static memebers of [NavigationTransition]
  Future<dynamic>? replaceWithTransition(Widget page,
      {bool? opaque,
      String? transition,
      Duration? duration,
      bool? popGesture}) {
    return Get.off(
      page,
      transition: _getTransitionOrDefault(transition!),
      duration: duration!,
      popGesture: popGesture ?? Get.isPopGestureEnable,
      opaque: opaque ?? Get.isOpaqueRouteDefault,
    );
  }

  /// Pops the current scope and indicates if you can pop again
  bool back({dynamic result}) {
    Get.back(result: result);
    return Get.key.currentState!.canPop();
  }

  /// Pops the back stack until the predicate is satisfied
  void popUntil(RoutePredicate predicate) {
    Get.key.currentState!.popUntil(predicate);
  }

  /// Pops the back stack the number of times you indicate with [popTimes]
  void popRepeated(int popTimes) {
    Get.close(popTimes);
  }

  /// Pushes [routeName] onto the navigation stack
  Future? navigateTo(String routeName, {dynamic arguments}) {
    return Get.toNamed(routeName, arguments: arguments);
  }

  /// Pushes [view] onto the navigation stack
  Future<dynamic>? navigateToView(Widget view, {dynamic arguments}) {
    return Get.to(view, arguments: arguments);
  }

  /// Replaces the current route with the [routeName]
  Future<dynamic>? replaceWith(String routeName, {dynamic arguments}) {
    return Get.offNamed(routeName, arguments: arguments);
  }

  /// Clears the entire back stack and shows [routeName]
  Future<dynamic>? clearStackAndShow(String routeName, {dynamic arguments}) {
    return Get.offAllNamed(routeName, arguments: arguments);
  }

  /// Pops the navigation stack until there's 1 view left then pushes [routeName] onto the stack
  Future<dynamic>? clearTillFirstAndShow(String routeName,
      {dynamic arguments}) {
    _clearBackstackTillFirst();

    return navigateTo(routeName, arguments: arguments);
  }

  /// Pops the navigation stack until there's 1 view left then pushes [view] onto the stack
  Future<dynamic>? clearTillFirstAndShowView(Widget view, {dynamic arguments}) {
    _clearBackstackTillFirst();

    return navigateToView(view, arguments: arguments);
  }

  /// Push route and clear stack until predicate is satisfied
  Future<dynamic>? pushNamedAndRemoveUntil(String routeName,
      {RoutePredicate? predicate, arguments, int? id}) {
    return Get.offAllNamed(
      routeName,
      predicate: predicate,
      arguments: arguments,
      id: id,
    );
  }

  void _clearBackstackTillFirst() {
    navigatorKey.currentState!.popUntil((Route route) => route.isFirst);
  }

  Transition? _getTransitionOrDefault(String transition) {
    String _transition = transition.toLowerCase();
    return _transitions[_transition] ?? Get.defaultTransition;
  }
}
