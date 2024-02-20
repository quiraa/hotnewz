import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/features/news/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticle();
}
