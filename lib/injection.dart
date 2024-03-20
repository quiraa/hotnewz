import 'package:dio/dio.dart';
import 'package:flutter_news_app/features/data/repository/article_repository_impl.dart';
import 'package:flutter_news_app/features/data/sources/local/news_database.dart';
import 'package:flutter_news_app/features/data/sources/remote/api_service.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';
import 'package:flutter_news_app/features/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/get_saved_articles_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/remove_article_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/save_article_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/search_article_usecase.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_bloc.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorNewsDatabase.databaseBuilder('news_database.db').build();

  injection.registerSingleton<NewsDatabase>(database);

  injection.registerSingleton<Dio>(Dio());

  injection.registerSingleton<ApiService>(ApiService(injection()));

  injection.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(injection(), injection()),
  );

  injection.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(injection()),
  );

  injection.registerSingleton<SearchArticleUseCase>(
    SearchArticleUseCase(injection()),
  );

  injection.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(injection()),
  );

  injection.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(injection()),
  );

  injection.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(injection()),
  );

  injection.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(injection()),
  );

  injection.registerFactory<SearchArticleBloc>(
    () => SearchArticleBloc(injection()),
  );

  injection.registerFactory<LocalArticleBloc>(
    () => LocalArticleBloc(injection(), injection(), injection()),
  );
}
