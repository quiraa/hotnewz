import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/core/usecases/usecases.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';

class SearchArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, SearchArticleParams> {
  final ArticleRepository repository;

  SearchArticleUseCase(this.repository);

  @override
  Future<DataState<List<ArticleEntity>>> call({SearchArticleParams? params}) {
    return repository.searchNewsArticles(params!.query);
  }
}

class SearchArticleParams {
  final String query;

  SearchArticleParams(this.query);
}
