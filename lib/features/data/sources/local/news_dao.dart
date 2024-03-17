import 'package:floor/floor.dart';
import 'package:flutter_news_app/features/domain/entity/bookmark_entity.dart';

@dao
abstract class NewsDao {
  @Query('SELECT * FROM bookmark')
  Future<List<BookmarkEntity>> getBookmarks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addToBookmark(BookmarkEntity bookmark);

  @delete
  Future<void> deleteFromBookmark(BookmarkEntity bookmark);
}
