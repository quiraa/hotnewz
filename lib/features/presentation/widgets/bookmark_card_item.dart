import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/domain/entity/bookmark_entity.dart';

class BookmarkCardItem extends StatelessWidget {
  final BookmarkEntity? bookmark;
  final bool? isRemovable;
  final void Function(BookmarkEntity article)? onRemove;
  final void Function(String webUrl)? onUrlPressed;

  const BookmarkCardItem({
    Key? key,
    this.bookmark,
    this.isRemovable,
    this.onRemove,
    this.onUrlPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
