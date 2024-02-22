import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/routes_configuration.dart';
import 'package:flutter_news_app/config/themes/theme.dart';
import 'package:flutter_news_app/news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/news/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/injection.dart';
import 'package:flutter_news_app/news/presentation/pages/home/home_page.dart';

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
      create: (context) => injection()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News App',
        theme: NewsTheme().theme(),
        onGenerateRoute: RoutesConfiguration().generateRoute,
        home: const HomePage(),
      ),
    );
  }
}
