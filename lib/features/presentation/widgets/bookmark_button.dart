import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BookmarkButton extends StatefulWidget {
  final bool isBookmark;
  final void Function() onFabClick;

  const BookmarkButton({
    Key? key,
    required this.isBookmark,
    required this.onFabClick,
  }) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        onPressed: widget.onFabClick,
        icon: Icon(
          widget.isBookmark ? Ionicons.bookmark : Ionicons.bookmark_outline,
        ),
      ),
    );
  }
}
