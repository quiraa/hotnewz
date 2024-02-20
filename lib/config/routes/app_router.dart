import 'package:flutter/material.dart';

class AppRouter {
  void push(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void pushAndReplace(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
