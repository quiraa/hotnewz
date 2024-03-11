abstract class RemoteArticleEvent {
  final String? query;

  const RemoteArticleEvent({this.query});
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}

class SearchArticles extends RemoteArticleEvent {
  const SearchArticles(String query) : super(query: query);
}
