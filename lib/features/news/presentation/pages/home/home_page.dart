import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/news/presentation/bloc/article/remote/remote_article_state.dart';

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
        return ListView.builder(
          itemCount: state.articles!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('{$index}'),
            );
          },
        );
      }
      return const SizedBox();
    });
  }
}
