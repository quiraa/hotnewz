import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app/config/routes/app_router.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/config/themes/typography.dart';
import 'package:flutter_news_app/core/utils/utils.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/domain/entity/bookmark_entity.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_event.dart';
import 'package:ionicons/ionicons.dart';

class DetailPage extends HookWidget {
  final ArticleEntity? article;

  const DetailPage({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => AppRouter().pop(context),
        icon: const Icon(Ionicons.chevron_back),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              final bookmark = BookmarkEntity(
                null,
                article?.title ?? '',
                article?.urlToImage ?? '',
                article?.description ?? '',
                article?.description ?? '',
                article?.publishedAt ?? '',
              );
              BlocProvider.of<LocalArticleBloc>(context).add(
                SaveArticleEvent(bookmark),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Article Saved Successfully')),
              );
            },
            icon: Icon(
              Icons.bookmark_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndDate(),
          _buildBodyImage(),
          _buildBodyContent(),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: SizedBox(
              width: double.maxFinite,
              child: FilledButton.tonal(
                onPressed: () {
                  AppRouter().push(
                    context,
                    ScreenRoutes.article,
                    arguments: article?.url ?? '',
                  );
                },
                child: const Text(
                  'Read More',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article?.title ?? '',
            style: NewsTypography.articleTitle,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  Utils().formatDateAndTime(article?.publishedAt ?? ''),
                  style: NewsTypography.articleDate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Ionicons.person_circle_outline, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  article?.author ?? '',
                  style: NewsTypography.articleDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyImage() {
    return CachedNetworkImage(
      imageUrl: article?.urlToImage ?? '',
      placeholder: (context, url) => Container(
        margin: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.withOpacity(0.1),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'No Image Provided',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      width: double.maxFinite,
      height: 300.0,
      fit: BoxFit.cover,
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '${article!.description ?? ''}\n\n${article!.content ?? ''}',
        style: NewsTypography.articleDescription,
      ),
    );
  }
}
