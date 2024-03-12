import 'package:flutter_news_app/core/usecases/usecases.dart';
import 'package:flutter_news_app/features/domain/entities/bookmark_entity.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<BookmarkEntity>, void> {
  final ArticleRepository repository;

  GetSavedArticlesUseCase(this.repository);

  @override
  Future<List<BookmarkEntity>> call({void params}) {
    return repository.getSavedArticles();
  }
}
