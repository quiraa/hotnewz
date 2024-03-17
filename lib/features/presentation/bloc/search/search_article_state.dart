import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';

abstract class SearchArticleState extends Equatable {
  final List<ArticleEntity>? articles;

  final DioException? error;

  const SearchArticleState({this.articles, this.error});

  @override
  List<Object?> get props => [articles!, error!];
}

class SearchArticleLoading extends SearchArticleState {
  const SearchArticleLoading();
}

class DiscoverArticleSuccess extends SearchArticleState {
  const DiscoverArticleSuccess(List<ArticleEntity> articles)
      : super(articles: articles);
}

class SearchArticleSuccess extends SearchArticleState {
  const SearchArticleSuccess(List<ArticleEntity> articles)
      : super(articles: articles);
}

class SearchArticleError extends SearchArticleState {
  const SearchArticleError(DioException error) : super(error: error);
}
