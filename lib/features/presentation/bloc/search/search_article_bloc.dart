import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/features/domain/usecase/search_article_usecase.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/search/search_article_state.dart';

class SearchArticleBloc extends Bloc<SearchArticleEvent, SearchArticleState> {
  final SearchArticleUseCase searchArticleUseCase;
  // final GetArticleUseCase getArticleUseCase;

  SearchArticleBloc(
    this.searchArticleUseCase,
  ) : super(const SearchArticleLoading()) {
    // on<DiscoverArticles>(onDiscoverArticles);
    on<SearchArticles>(onSearchArticle);
  }

  // void onDiscoverArticles(
  //   DiscoverArticles event,
  //   Emitter<SearchArticleState> emit,
  // ) async {
  //   emit(const SearchArticleLoading());
  //   final discovers = await getArticleUseCase(params: event.category);

  //   if (discovers is DataSuccess) {
  //     emit(DiscoverArticleSuccess(discovers.data!));
  //   }

  //   if (discovers is DataFailed) {
  //     emit(SearchArticleError(discovers.error!));
  //   }
  // }

  void onSearchArticle(
    SearchArticles event,
    Emitter<SearchArticleState> emit,
  ) async {
    emit(const SearchArticleLoading());
    final searches = await searchArticleUseCase(
      params: SearchArticleParams(event.query!),
    );

    if (searches is DataSuccess && searches.data!.isNotEmpty) {
      emit(SearchArticleSuccess(searches.data!));
    }

    if (searches is DataFailed) {
      emit(SearchArticleError(searches.error!));
    }
  }
}
