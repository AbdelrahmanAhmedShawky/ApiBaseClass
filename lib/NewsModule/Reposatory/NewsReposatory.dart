import 'package:flutter_app_base_api/APIService/api_base_helper.dart';
import 'package:flutter_app_base_api/NewsModule/Model/newsModel.dart';

abstract class INewsAPi {
  Future<List<Article>> getCategoryNews(String newsType);

  Future<List<Article>> getTopHeadlines();
}

class NewsRepository extends INewsAPi {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  @override
  Future<List<Article>> getCategoryNews(String newsType) async {
    final response = await apiBaseHelper.get(newsType);
    return News.fromJson(response).articles;
  }

  @override
  Future<List<Article>> getTopHeadlines() async {
    final response = await apiBaseHelper.get("top-headlines");
    return News.fromJson(response).articles;
  }
}
