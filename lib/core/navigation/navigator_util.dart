import 'package:flutter/material.dart';

class NavigatorUtil {
  NavigatorUtil._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context {
    final currentContext = navigatorKey.currentContext;
    if (currentContext == null) {
      throw StateError('Navigator context is not ready.');
    }
    return currentContext;
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> push<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState!.push<T>(route);
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  static bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }
}
