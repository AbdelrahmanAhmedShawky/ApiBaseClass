import 'dart:async';

import 'package:flutter_app_base_api/APIService/api_response.dart';
import 'package:flutter_app_base_api/NewsModule/Model/newsModel.dart';
import 'package:flutter_app_base_api/NewsModule/Reposatory/NewsReposatory.dart';

class NewsBloc {
  NewsRepository _newsRepository;

  StreamController _newsListController;

  StreamSink<ApiResponse<List<Article>>> get newsListSink =>
      _newsListController.sink;

  Stream<ApiResponse<List<Article>>> get newsListStream =>
      _newsListController.stream;

  NewsBloc() {
    _newsListController = StreamController<ApiResponse<List<Article>>>();
    _newsRepository = NewsRepository();
  }

  fetchCategoryNewsList(String newsType) async {
    newsListSink.add(ApiResponse.loading('Fetching News '));
    try {
      List<Article> articles = await _newsRepository.getCategoryNews(newsType);
      newsListSink.add(ApiResponse.completed(articles));
    } catch (e) {
      newsListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTopHeadlinesList() async {
    newsListSink.add(ApiResponse.loading('Fetching News '));
    try {
      List<Article> articles = await _newsRepository.getTopHeadlines();
      newsListSink.add(ApiResponse.completed(articles));
    } catch (e) {
      newsListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _newsListController?.close();
  }
}
