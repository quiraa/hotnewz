import 'package:dio/dio.dart';
import 'package:flutter_news_app/features/data/repository/article_repository_impl.dart';
import 'package:flutter_news_app/features/data/sources/remote/api_service.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';
import 'package:flutter_news_app/features/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/search_article_usecase.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  injection.registerSingleton<Dio>(Dio());

  injection.registerSingleton<ApiService>(ApiService(injection()));

  injection.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(
      injection(),
    ),
  );

  injection.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(
      injection(),
    ),
  );

  injection.registerSingleton<SearchArticleUseCase>(
    SearchArticleUseCase(
      injection(),
    ),
  );

  injection.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(
      injection(),
      injection(),
    ),
  );
}
