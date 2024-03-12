import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/core/resources/data_state.dart';
import 'package:flutter_news_app/features/data/models/article_models.dart';
import 'package:flutter_news_app/features/data/sources/remote/api_service.dart';
import 'package:flutter_news_app/features/domain/entity/article_entity.dart';
import 'package:flutter_news_app/features/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ApiService apiService;

  ArticleRepositoryImpl(this.apiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle(String category) async {
    try {
      final articles = await apiService.getNewsArticles(
        apiKey: Constants.apiKey,
        country: Constants.countryQuery,
        category: category,
      );

      if (articles.response.statusCode == HttpStatus.ok) {
        return DataSuccess(articles.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: articles.response.requestOptions,
            error: articles.response.statusMessage,
            message: articles.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: articles.response,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleModel>>> searchNewsArticles(
    String query,
  ) async {
    try {
      final result = await apiService.searchNewsArticles(
        query: query,
        apiKey: Constants.apiKey,
      );

      if (result.response.statusCode == HttpStatus.ok) {
        return DataSuccess(result.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: result.response.requestOptions,
            error: result.response.statusMessage,
            message: result.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: result.response,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
