import 'package:flutter/material.dart';
import 'package:news_apps/data/news_service.dart';
import 'package:news_apps/models/article.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService newsService;

  NewsProvider(this.newsService);

  bool isLoading = false;
  String errorMessage = '';

  List<Article> _allArticles = [];
  List<Article> articles = [];

  Future<void> fetchNews() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      _allArticles = await newsService.fetchBusinessNews();
      articles = _allArticles;
    } catch (e) {
      errorMessage = 'News failed to load';
    }

    isLoading = false;
    notifyListeners();
  }

  void searchByTitle(String query) {
    final search = query.toLowerCase();

    if (search.isEmpty) {
      articles = _allArticles;
    } else {
      articles = _allArticles.where((article) {
        return article.title.toLowerCase().contains(search);
      }).toList();
    }

    notifyListeners();
  }
}
