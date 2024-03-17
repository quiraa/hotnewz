import 'package:floor/floor.dart';
import 'package:flutter_news_app/features/data/sources/local/news_dao.dart';
import 'package:flutter_news_app/features/domain/entity/bookmark_entity.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'news_database.g.dart';

@Database(version: 1, entities: [BookmarkEntity])
abstract class NewsDatabase extends FloorDatabase {
  NewsDao get dao;
}
