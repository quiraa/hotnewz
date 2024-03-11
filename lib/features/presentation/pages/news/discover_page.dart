import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/app_router.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/features/domain/entities/article_entity.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_news_app/features/presentation/widgets/news_card_item.dart';
import 'package:flutter_news_app/features/presentation/widgets/search_field.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 86,
      automaticallyImplyLeading: false,
      title: SearchField(
        searchController: _searchController,
        onSearch: () => BlocProvider.of<RemoteArticleBloc>(context)
          ..add(
            SearchArticles(_searchController.text.toString()),
          ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RemoteArticlesLoading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case RemoteArticlesError:
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(state.error!.message ?? ''),
              ),
            );

          case SearchArticleSuccess:
            return SearchContent(
              searchedArticles: state.articles!,
              onArticleClicked: (article) {
                _onArticlePressed(context, article);
              },
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    AppRouter().push(context, ScreenRoutes.detail, arguments: article);
  }
}

class SearchContent extends StatefulWidget {
  final List<ArticleEntity> searchedArticles;
  final void Function(ArticleEntity article) onArticleClicked;

  const SearchContent({
    Key? key,
    required this.searchedArticles,
    required this.onArticleClicked,
  }) : super(key: key);

  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  @override
  Widget build(BuildContext context) {
    switch (widget.searchedArticles.isNotEmpty) {
      case true:
        return AvailableNewsContent(
          articles: widget.searchedArticles,
          onArticleClicked: widget.onArticleClicked,
        );

      case false:
        return const SizedBox();
    }
  }
}
