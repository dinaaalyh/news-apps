import 'package:flutter/material.dart';
import 'package:news_apps/data/news_service.dart';
import 'package:news_apps/models/article.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService newsService;

  NewsProvider(this.newsService);

  bool isLoading = false;
  String errorMessage = '';
  List<Article> articles = [];

  Future<void> fetchNews() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      articles = await newsService.fetchBusinessNews();
    } catch (e) {
      errorMessage = 'News failed to load';
    }

    isLoading = false;
    notifyListeners();
  }
}
