import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticle(String category);

  Future<DataState<List<ArticleEntity>>> searchNewsArticles(String query);
}
