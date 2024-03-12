import 'package:flutter_news_app/core/usecases/usecases.dart';
import 'package:flutter_news_app/features/domain/entities/bookmark_entity.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';

class SaveArticleUseCase implements UseCase<void, BookmarkEntity> {
  final ArticleRepository repository;

  SaveArticleUseCase(this.repository);

  @override
  Future<void> call({BookmarkEntity? params}) {
    return repository.saveArticle(params!);
  }
}
