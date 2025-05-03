import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void goTo(name) {
    navigatorKey.currentState?.pushNamed(name);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

  void goToAndReplace(Widget name) {
    navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (_) => name));
  }
}
