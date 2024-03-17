import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/routes_configuration.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/config/themes/theme.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_bloc.dart';
import 'package:flutter_news_app/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injection<RemoteArticleBloc>()
            ..add(GetArticlesByCategory('general')),
        ),
        BlocProvider(create: (_) => injection<SearchArticleBloc>()),
      ],
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
