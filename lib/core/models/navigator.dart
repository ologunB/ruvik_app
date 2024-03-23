import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static final _navKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navKey => _navKey;

  static bool get canPop => _navKey.currentState!.canPop();
  static void doPop([result]) {
    if (canPop) return _navKey.currentState!.pop(result);
  }
}
