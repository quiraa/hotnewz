import 'package:flutter_news_app/features/domain/entity/bookmark_entity.dart';

abstract class LocalArticleEvent {
  final BookmarkEntity? bookmark;
  final int? id;

  const LocalArticleEvent({this.bookmark, this.id});
}

class GetSavedArticlesEvent extends LocalArticleEvent {
  const GetSavedArticlesEvent();
}

class RemoveArticleEvent extends LocalArticleEvent {
  const RemoveArticleEvent(BookmarkEntity bookmark) : super(bookmark: bookmark);
}

class SaveArticleEvent extends LocalArticleEvent {
  const SaveArticleEvent(BookmarkEntity bookmark) : super(bookmark: bookmark);
}

class CheckBookmarkEvent extends LocalArticleEvent {
  const CheckBookmarkEvent(int id) : super(id: id);
}
