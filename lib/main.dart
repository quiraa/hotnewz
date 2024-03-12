import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/routes_configuration.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/config/themes/theme.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => injection()..add(GetArticlesByCategory('general')),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        themeMode: ThemeMode.light,
        darkTheme: NewsTheme().darkTheme(),
        theme: NewsTheme().lightTheme(),
        onGenerateRoute: RoutesConfiguration().generateRoute,
        initialRoute: ScreenRoutes.home,
      ),
    );
  }
}
