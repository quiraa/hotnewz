import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app/config/routes/app_router.dart';
import 'package:flutter_news_app/config/themes/typography.dart';
import 'package:flutter_news_app/core/utils/date_converter.dart';
import 'package:flutter_news_app/news/domain/entities/article_entity.dart';

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
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => AppRouter().pop(context),
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTitleAndDate(),
          _buildBodyImage(),
          _buildBodyContent(),
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
              const Icon(Icons.timeline, size: 16),
              const SizedBox(width: 4),
              Text(
                Utils().formatDateAndTime(article?.publishedAt ?? ''),
                style: NewsTypography.articleDate,
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
