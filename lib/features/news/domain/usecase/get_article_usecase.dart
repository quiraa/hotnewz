import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/core/usecases/usecases.dart';
import 'package:flutter_news_app/features/news/domain/entities/article_entity.dart';
import 'package:flutter_news_app/features/news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;

  GetArticleUseCase(this.articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return articleRepository.getNewsArticle();
  }
}
