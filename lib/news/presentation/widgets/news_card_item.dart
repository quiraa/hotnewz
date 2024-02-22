import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/config/themes/typography.dart';
import 'package:flutter_news_app/core/utils/date_converter.dart';
import 'package:flutter_news_app/news/domain/entities/article_entity.dart';

class NewsCardItem extends StatelessWidget {
  final ArticleEntity? article;
  final void Function(ArticleEntity article)? onArticleClick;

  const NewsCardItem({
    Key? key,
    required this.article,
    required this.onArticleClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _onArticleClicked(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildImageBody(context),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 4,
              child: _buildInformationBody(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageBody(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article?.urlToImage ?? '',
      placeholder: (context, url) => Container(
        margin: const EdgeInsets.all(32.0),
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.withOpacity(0.1),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
      width: 128.0,
      height: 186.0,
      fit: BoxFit.cover,
    );
  }

  Widget _buildInformationBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article?.title ?? '',
            maxLines: 3,
            style: NewsTypography.newsCardTitle,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            article?.description ?? '',
            maxLines: 2,
            style: NewsTypography.newsCardDescription,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              children: [
                const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.calendar_today,
                    size: 20.0,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(
                    width: 8.0,
                  ),
                ),
                TextSpan(
                  text: Utils().formatDate(article?.publishedAt ?? ''),
                  style: NewsTypography.newsCardDate,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onArticleClicked() {
    if (onArticleClick != null) {
      onArticleClick!(article!);
    }
  }
}
