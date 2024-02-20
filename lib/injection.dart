import 'package:dio/dio.dart';
import 'package:flutter_news_app/features/news/data/repository/article_repository_impl.dart';
import 'package:flutter_news_app/features/news/data/sources/remote/api_service.dart';
import 'package:flutter_news_app/features/news/domain/repository/article_repository.dart';
import 'package:flutter_news_app/features/news/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  injection.registerSingleton<Dio>(Dio());

  injection.registerSingleton<ApiService>(ApiService(injection()));

  injection
      .registerSingleton<ArticleRepository>(ArticleRepositoryImpl(injection()));

  injection
      .registerSingleton<GetArticleUseCase>(GetArticleUseCase(injection()));

  injection
      .registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(injection()));
}
