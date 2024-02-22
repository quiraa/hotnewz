import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/news/domain/entities/article_entity.dart';
import 'package:flutter_news_app/news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/news/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_news_app/news/presentation/widgets/news_card_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'NewsApp',
        style: TextStyle(color: Colors.black),
      ),
      surfaceTintColor: Colors.transparent,
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (context, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is RemoteArticlesError) {
        return const Center(child: Icon(Icons.refresh));
      }

      if (state is RemoteArticlesSuccess) {
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          separatorBuilder: (context, index) => const SizedBox(
            height: 8.0,
          ),
          itemCount: state.articles!.length,
          itemBuilder: (context, index) {
            return NewsCardItem(
              article: state.articles![index],
              onArticleClick: (article) => _onArticlePressed(context, article),
            );
          },
        );
      }
      return const SizedBox();
    });
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, ScreenRoutes.detail, arguments: article);
  }
}
