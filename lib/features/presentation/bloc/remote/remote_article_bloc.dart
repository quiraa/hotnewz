import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/features/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/search_article_usecase.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase getArticleUseCase;
  final SearchArticleUseCase searchArticleUseCase;

  RemoteArticleBloc(
    this.getArticleUseCase,
    this.searchArticleUseCase,
  ) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticle);
    on<SearchArticles>(onSearchArticle);
  }

  void onGetArticle(GetArticles event, Emitter<RemoteArticleState> emit) async {
    emit(const RemoteArticlesLoading());
    final articles = await getArticleUseCase();

    if (articles is DataSuccess && articles.data!.isNotEmpty) {
      emit(RemoteArticlesSuccess(articles.data!));
    }

    if (articles is DataFailed) {
      print(articles.error!.message);
      emit(RemoteArticlesError(articles.error!));
    }
  }

  void onSearchArticle(
    SearchArticles event,
    Emitter<RemoteArticleState> emit,
  ) async {
    emit(const RemoteArticlesLoading());
    final searches = await searchArticleUseCase(
      params: SearchArticleParams(event.query!),
    );

    if (searches is DataSuccess && searches.data!.isNotEmpty) {
      emit(SearchArticleSuccess(searches.data!));
    }

    if (searches is DataFailed) {
      print(searches.error!.message);
      emit(RemoteArticlesError(searches.error!));
    }
  }
}
