abstract class RemoteArticleEvent {
  final String? query;
  final String? category;

  const RemoteArticleEvent({this.query, this.category});
}

class GetArticlesByCategory extends RemoteArticleEvent {
  GetArticlesByCategory(String category) : super(category: category);
}
