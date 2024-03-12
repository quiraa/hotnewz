import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/app_router.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/config/themes/typography.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_news_app/features/presentation/widgets/news_card_item.dart';
import 'package:flutter_news_app/features/presentation/widgets/search_field.dart';
import 'package:icons_flutter/icons_flutter.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({Key? key}) : super(key: key);

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
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesome.newspaper_o,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Search News',
                    style: NewsTypography.articleTitle,
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    AppRouter().push(context, ScreenRoutes.detail, arguments: article);
  }
}

class SearchContent extends StatelessWidget {
  final List<ArticleEntity> searchedArticles;
  final void Function(ArticleEntity article) onArticleClicked;

  const SearchContent({
    Key? key,
    required this.searchedArticles,
    required this.onArticleClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (searchedArticles.isNotEmpty) {
      case true:
        return AvailableNewsContent(
          articles: searchedArticles,
          onArticleClicked: onArticleClicked,
        );

      case false:
        return const SizedBox();
    }
  }
}
