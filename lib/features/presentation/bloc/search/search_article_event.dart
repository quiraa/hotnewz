abstract class SearchArticleEvent {
  final String? query;
  final String? category;

  const SearchArticleEvent({this.category, this.query});
}

class SearchArticles extends SearchArticleEvent {
  const SearchArticles(String query) : super(query: query);
}
