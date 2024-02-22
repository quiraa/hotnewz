import 'package:flutter/widgets.dart';

class NewsTypography {
  static const newsCardTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
  );

  static const newsCardDescription = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
  );

  static const newsCardDate = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
  );

  static const articleTitle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    overflow: TextOverflow.clip,
  );

  static const articleDate = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.clip,
  );

  static const articleDescription = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.clip,
  );
}
