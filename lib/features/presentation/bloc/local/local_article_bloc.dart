import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/domain/usecase/get_saved_articles_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/remove_article_usecase.dart';
import 'package:flutter_news_app/features/domain/usecase/save_article_usecase.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_event.dart';
import 'package:flutter_news_app/features/presentation/bloc/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticlesUseCase getSavedArticlesUseCase;
  final RemoveArticleUseCase removeArticleUseCase;
  final SaveArticleUseCase saveArticleUseCase;

  LocalArticleBloc(
    this.getSavedArticlesUseCase,
    this.removeArticleUseCase,
    this.saveArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticlesEvent>(onGetSavedArticles);
    on<RemoveArticleEvent>(onRemoveArticle);
    on<SaveArticleEvent>(onSaveArticle);
  }

  void onGetSavedArticles(
    GetSavedArticlesEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    final bookmarks = await getSavedArticlesUseCase();
    emit(LocalArticleSuccess(bookmarks));
  }

  void onSaveArticle(
    SaveArticleEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    await saveArticleUseCase(params: event.bookmark);
    final allBookmarks = await getSavedArticlesUseCase();
    emit(LocalArticleSuccess(allBookmarks));
  }

  void onRemoveArticle(
    RemoveArticleEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    await removeArticleUseCase(params: event.bookmark);
    final allBookmarks = await getSavedArticlesUseCase();
    emit(LocalArticleSuccess(allBookmarks));
  }

  void onCheckSavedArticle(
    CheckBookmarkEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    final allBookmarks = await getSavedArticlesUseCase();
    final isBookmarked =
        allBookmarks.any((bookmark) => bookmark.id == event.id);
    if (isBookmarked) {
      emit(const LocalBookmarkedState());
    } else {
      emit(const LocalNotBookmarkedState());
    }
  }
}
