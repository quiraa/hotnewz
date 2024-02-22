// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/news/data/models/article_models.dart';
import 'package:flutter_news_app/news/data/sources/remote/api_service.dart';
import 'package:flutter_news_app/news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ApiService apiService;
  ArticleRepositoryImpl(this.apiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final httpResponse = await apiService.getNewsArticles(
        apiKey: Constants.apiKey,
        country: Constants.countryQuery,
        category: Constants.categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
