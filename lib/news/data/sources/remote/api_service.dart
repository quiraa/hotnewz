import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/news/data/models/article_models.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
