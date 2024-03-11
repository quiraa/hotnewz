import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/app_router.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/features/domain/entities/article_entity.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_news_app/features/presentation/widgets/news_card_item.dart';
import 'package:flutter_news_app/injection.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => injection()..add(const GetArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        drawer: const NewsPageDrawer(),
        drawerEnableOpenDragGesture: true,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Top Headlines'),
      surfaceTintColor: Colors.transparent,
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
                child: Text(state.error!.message ?? 'Error'),
              ),
            );

          case RemoteArticlesSuccess:
            return NewsContent(
              articles: state.articles ?? [],
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

class NewsContent extends StatefulWidget {
  final List<ArticleEntity> articles;
  final void Function(ArticleEntity article) onArticleClicked;

  const NewsContent({
    Key? key,
    required this.articles,
    required this.onArticleClicked,
  }) : super(key: key);

  @override
  _NewsContentState createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  final listChoices = <CategoryItemChoice>[
    CategoryItemChoice(1, 'General'),
    CategoryItemChoice(2, 'Entertainment'),
    CategoryItemChoice(3, 'Technology'),
    CategoryItemChoice(4, 'Business'),
    CategoryItemChoice(5, 'Health'),
    CategoryItemChoice(6, 'Science'),
    CategoryItemChoice(7, 'Sports'),
  ];

  int idSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: true,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 8.0,
                  children: listChoices.map((item) {
                    return ChoiceChip(
                      label: Text(item.label),
                      selected: idSelected == item.id,
                      onSelected: (_) => setState(() {
                        idSelected = item.id;
                      }),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(child: _buildListArticle()),
      ],
    );
  }

  Widget _buildListArticle() {
    switch (widget.articles.isNotEmpty) {
      case true:
        return AvailableNewsContent(
          articles: widget.articles,
          onArticleClicked: widget.onArticleClicked,
        );

      case false:
        return const SizedBox();
    }
  }
}

class NewsPageDrawer extends StatelessWidget {
  const NewsPageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildDrawerHeader(context),
            buildDrawerContent(context),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).colorScheme.primary,
      width: double.maxFinite,
      height: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 86,
            height: 86,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'U',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Username',
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerContent(BuildContext context) {
    return Wrap(
      runSpacing: 16.0,
      children: [
        ListTile(
          leading: const Icon(Icons.settings_rounded),
          title: const Text('Settings'),
          onTap: () {
            Navigator.of(context).pop();
            AppRouter().push(context, ScreenRoutes.settings);
          },
        ),
      ],
    );
  }
}

class CategoryItemChoice {
  final int id;
  final String label;

  CategoryItemChoice(this.id, this.label);
}
