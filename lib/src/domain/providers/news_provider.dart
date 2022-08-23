import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/article_model.dart';
import '../models/category_model.dart';

class NewsProvider with ChangeNotifier {
  late Category? categorySelected;
  List<Article> articles = [];
  static String apiKey = 'YOUR_API_KEY';

  Future<List<Article>> getArticlesByCategoryConditionally(
    String category,
  ) async {
    if (articles.isEmpty) {
      await getArticlesByCategory(category);
    } else {
      bool categoryLoaded = false;
      for (var a in articles) {
        if (a.category == category) categoryLoaded = true;
      }
      if (!categoryLoaded) await getArticlesByCategory(category);
    }

    return articles;
  }

  Future<void> getArticlesByCategory(String category) async {
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=mx&category=$category&apiKey=$apiKey',
      ),
    );
    print('hice un get de la categoria $category');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      final List<Article> tempArticles =
          body.map((a) => Article.fromMap(a)).toList();

      for (var article in tempArticles) {
        if (articles.contains(article)) {
          print('ya contiene esa noticia');
        } else {
          article.category = category;
          articles.add(article);
        }
      }

      notifyListeners();
    } else {
      throw ('CAN\'T GET ARTICLES');
    }
  }

  Future<List<Article>> getArticlesByQuery(String query) async {
    const String date = '2022-07-22';
    String url =
        'https://newsapi.org/v2/everything?q=$query&from=$date&sortBy=popularity&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    print('hice un get de con la query $query');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      final List<Article> tempArticles =
          body.map((a) => Article.fromMap(a)).toList();

      return tempArticles;
    } else {
      throw ('CAN\'T GET ARTICLES');
    }
  }
}
