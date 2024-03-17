import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/features/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase getArticleUseCase;

  RemoteArticleBloc(
    this.getArticleUseCase,
  ) : super(const RemoteArticlesLoading()) {
    on<GetArticlesByCategory>(onGetArticle);
  }

  void onGetArticle(
      GetArticlesByCategory event, Emitter<RemoteArticleState> emit) async {
    emit(const RemoteArticlesLoading());
    final articles = await getArticleUseCase(
      params: event.category,
    );

    if (articles is DataSuccess && articles.data!.isNotEmpty) {
      emit(RemoteArticlesSuccess(articles.data!));
    }

    if (articles is DataFailed) {
      emit(RemoteArticlesError(articles.error!));
    }
  }
}
