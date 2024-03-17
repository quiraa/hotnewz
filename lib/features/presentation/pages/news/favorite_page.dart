import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_state.dart';
import 'package:flutter_news_app/injection.dart';

class FavoritePage extends HookWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injection<LocalArticleBloc>()..add(const GetSavedArticlesEvent()),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case LocalArticleError:
          case LocalArticleLoading:
          case LocalArticleSuccess:
          default:
            return const SizedBox();
        }
      },
    );
  }
}
