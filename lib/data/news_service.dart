import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_apps/models/article.dart';
import 'package:news_apps/utils/api_constants.dart';
import 'package:news_apps/utils/api_key.dart';

class NewsService {
  Future<List<Article>> fetchBusinessNews() async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/top-headlines?country=us&category=business',
    );

    if (ApiKey.apiKey == 'ISI_API_KEY_DI_SINI') {
      throw Exception('API key belum diisi');
    }

    final response = await http.get(
      url,
      headers: {
        'X-Api-Key': ApiKey.apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List).map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('News failed to load');
    }
  }
}
