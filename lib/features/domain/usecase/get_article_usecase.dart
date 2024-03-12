import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/core/usecases/usecases.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, String> {
  final ArticleRepository articleRepository;

  GetArticleUseCase(this.articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({String? params}) {
    return articleRepository.getNewsArticle(params!);
  }
}
