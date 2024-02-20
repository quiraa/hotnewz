import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/themes/theme.dart';
import 'package:flutter_news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/news/presentation/pages/home/home_page.dart';
import 'package:flutter_news_app/injection.dart';

Future<void> main() async {
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
        title: 'Flutter Demo',
        theme: theme(),
        home: const HomePage(),
      ),
    );
  }
}
