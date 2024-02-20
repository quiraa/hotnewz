import 'package:flutter/material.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';

PageRoute _getPageRoute(String? routeName, Widget? screen) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName), builder: (context) => screen!);
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenRoutes.news:
    case ScreenRoutes.detail:
    case ScreenRoutes.bookmark:
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(
              'No Routes Defined For ${settings.name}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
  }
}
