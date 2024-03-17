import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static String routeName = '';

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void setRouteName(String routeName) {
    NavigationService.routeName = routeName;
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }
}
