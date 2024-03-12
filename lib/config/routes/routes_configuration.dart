import 'package:flutter/material.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/presentation/pages/detail/detail_page.dart';
import 'package:flutter_news_app/features/presentation/pages/home_page.dart';
import 'package:flutter_news_app/features/presentation/pages/settings_page.dart';
import 'package:flutter_news_app/features/presentation/pages/webview/article_webview.dart';

class RoutesConfiguration {
  PageRoute _getPageRoute({String? routeName, Widget? screen}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => screen!);
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.home:
        return _getPageRoute(
          routeName: settings.name,
          screen: const HomePage(),
        );

      case ScreenRoutes.detail:
        final args = settings.arguments as ArticleEntity;
        return _getPageRoute(
          routeName: settings.name,
          screen: DetailPage(article: args),
        );

      case ScreenRoutes.article:
        final newsUrl = settings.arguments as String;
        return _getPageRoute(
          routeName: ScreenRoutes.article,
          screen: ArticleWebView(newsUrl: newsUrl),
        );

      case ScreenRoutes.settings:
        return _getPageRoute(
          routeName: ScreenRoutes.settings,
          screen: const SettingsPage(),
        );

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
}
