// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/themes/typography.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_state.dart';
import 'package:flutter_news_app/features/presentation/pages/detail/detail_page.dart';
import 'package:flutter_news_app/features/presentation/widgets/news_card_item.dart';
import 'package:flutter_news_app/features/presentation/widgets/search_field.dart';
import 'package:flutter_news_app/injection.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _searchController = TextEditingController();

  int randomIndex = Random().nextInt(7);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchArticleBloc>(context).add(
      DiscoverArticles(Constants.newsCategories[randomIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: const Text('Discover'),
    );
  }

  Future<void> _refreshData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    BlocProvider.of<SearchArticleBloc>(context).add(
      DiscoverArticles(Constants.newsCategories[randomIndex]),
    );
  }

  Widget _buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshData(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: SearchField(
              searchController: _searchController,
              onSearch: () {
                // Menggunakan context dari _buildBody
                BlocProvider.of<SearchArticleBloc>(context).add(
                  SearchArticles(_searchController.text.toString()),
                );
              },
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  _buildContent() {
    return BlocBuilder<SearchArticleBloc, SearchArticleState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchArticleLoading:
            return const Center(
              child: CupertinoActivityIndicator(),
            );

          case SearchArticleError:
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

          case DiscoverArticleSuccess:
            return DiscoverContent(
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
                    CupertinoIcons.search,
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
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: DetailPage(article: article),
      withNavBar: false,
    );
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

class DiscoverContent extends StatelessWidget {
  final List<ArticleEntity> searchedArticles;
  final void Function(ArticleEntity article) onArticleClicked;

  const DiscoverContent({
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
