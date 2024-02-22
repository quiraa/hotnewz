import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/news/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news_app/news/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/news/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase getArticleUseCase;

  RemoteArticleBloc(this.getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticle);
  }

  void onGetArticle(GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
