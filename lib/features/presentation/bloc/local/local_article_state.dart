import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/features/domain/entity/bookmark_entity.dart';

abstract class LocalArticleState extends Equatable {
  final List<BookmarkEntity>? bookmarks;

  const LocalArticleState({this.bookmarks});

  @override
  List<Object?> get props => [bookmarks!];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleError extends LocalArticleState {
  const LocalArticleError();
}

class LocalArticleSuccess extends LocalArticleState {
  const LocalArticleSuccess(List<BookmarkEntity> bookmarks)
      : super(bookmarks: bookmarks);
}

class LocalBookmarkedState extends LocalArticleState {
  const LocalBookmarkedState();
}

class LocalNotBookmarkedState extends LocalArticleState {
  const LocalNotBookmarkedState();
}
