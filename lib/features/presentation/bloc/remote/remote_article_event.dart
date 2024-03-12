abstract class RemoteArticleEvent {
  final String? query;
  final String? category;

  const RemoteArticleEvent({this.query, this.category});
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}

class SearchArticles extends RemoteArticleEvent {
  const SearchArticles(String query) : super(query: query);
}

class GetArticlesByCategory extends RemoteArticleEvent {
  GetArticlesByCategory(String category) : super(category: category);
}
