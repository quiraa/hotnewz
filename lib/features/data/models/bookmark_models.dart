import 'package:floor/floor.dart';
import 'package:flutter_news_app/features/domain/entities/bookmark_entity.dart';

@Entity(tableName: 'bookmark', primaryKeys: ['id'])
class BookmarkModel extends BookmarkEntity {
  const BookmarkModel({
    @PrimaryKey(autoGenerate: true) int? id,
    String? title,
    String? photoUrl,
    String? publishedDate,
    String? webUrl,
  }) : super(
          id: id,
          title: title,
          photoUrl: photoUrl,
          publishedDate: publishedDate,
          webUrl: webUrl,
        );

  factory BookmarkModel.fromEntity(BookmarkEntity entity) {
    return BookmarkModel(
      id: entity.id,
      title: entity.title,
      photoUrl: entity.photoUrl,
      publishedDate: entity.publishedDate,
      webUrl: entity.webUrl,
    );
  }
}
