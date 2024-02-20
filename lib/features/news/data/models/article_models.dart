import 'package:floor/floor.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/features/news/domain/entities/article_entity.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  @override
  final Source? source;

  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    this.source,
  }) : super(
          id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] != null && json['urlToImage'] != ''
          ? json['urlToImage']
          : Constants.defaultImage,
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      source: Source.fromJson(json['source']),
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      id: entity.id,
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
      source: entity.source,
    );
  }
}
