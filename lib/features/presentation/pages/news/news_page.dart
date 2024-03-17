import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_news_app/features/presentation/pages/detail/detail_page.dart';
import 'package:flutter_news_app/features/presentation/pages/settings_page.dart';
import 'package:flutter_news_app/features/presentation/widgets/news_card_item.dart';

import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return SliderDrawer(
      animationDuration: 200,
      appBar: _buildAppBar(context),
      slider: SingleChildScrollView(
        child: Column(
          children: [
            buildDrawerHeader(context),
            buildDrawerContent(context),
          ],
        ),
      ),
      child: Column(
        children: [
          _buildCategoryChips(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  SliderAppBar _buildAppBar(BuildContext context) {
    return const SliderAppBar(
      title: Text(
        'Top Headlines',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarHeight: 86,
      isTitleCenter: false,
      drawerIconSize: 24,
      appBarPadding: EdgeInsets.only(top: 40),
    );
  }

  Widget _buildCategoryChips() {
    return ChipsChoice<int>.single(
      value: selectedId,
      choiceCheckmark: true,
      onChanged: (value) {
        setState(() => selectedId = value);
        selectedId = value;
        BlocProvider.of<RemoteArticleBloc>(context).add(
          GetArticlesByCategory(Constants.newsCategories[value].toLowerCase()),
        );
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: Constants.newsCategories,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.outlined(
        borderRadius: BorderRadius.circular(18),
        height: 36,
        selectedStyle: C2ChipStyle.filled(),
        checkmarkStyle: C2ChipCheckmarkStyle.round,
      ),
      scrollToSelectedOnChanged: true,
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RemoteArticlesLoading:
            return const Center(
              child: CupertinoActivityIndicator(),
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
              onArticleClicked: (article) =>
                  _onArticlePressed(context, article),
            );

          default:
            return const SizedBox();
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
          leading: const Icon(CupertinoIcons.settings_solid),
          title: const Text('Settings'),
          onTap: () {
            Navigator.of(context).pop();
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const SettingsPage(),
              withNavBar: false,
            );
          },
        ),
      ],
    );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
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

// class NewsPageDrawer extends StatelessWidget {
//   const NewsPageDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             buildDrawerHeader(context),
//             buildDrawerContent(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDrawerHeader(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       color: Theme.of(context).colorScheme.primary,
//       width: double.maxFinite,
//       height: 240,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 86,
//             height: 86,
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 'U',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text(
//               'Username',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 color: Theme.of(context).colorScheme.onPrimary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDrawerContent(BuildContext context) {
//     return Wrap(
//       runSpacing: 16.0,
//       children: [
//         ListTile(
//           leading: const Icon(Ionicons.md_settings),
//           title: const Text('Settings'),
//           onTap: () {
//             Navigator.of(context).pop();
//             PersistentNavBarNavigator.pushNewScreen(
//               context,
//               screen: const SettingsPage(),
//               withNavBar: false,
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// class CategoryItemChoice {
//   final int id;
//   final String label;

//   CategoryItemChoice(this.id, this.label);
// }
