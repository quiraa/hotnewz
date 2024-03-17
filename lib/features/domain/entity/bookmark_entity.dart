import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'bookmark')
class BookmarkEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? title;
  final String? photoUrl;
  final String? description;
  final String? url;
  final String? publishedAt;

  const BookmarkEntity(
    this.id,
    this.title,
    this.photoUrl,
    this.description,
    this.url,
    this.publishedAt,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        photoUrl,
        description,
        url,
        publishedAt,
      ];
}
