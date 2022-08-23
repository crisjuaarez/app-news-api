import 'package:flutter/material.dart';

import 'package:app_news_api/src/domain/models/article_model.dart';

import 'widgets/article_content.dart';
import 'widgets/detail_appbar.dart';

class DetailView extends StatelessWidget {
  const DetailView(this.article, {Key? key}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [DetailAppBar(article)],
        body: ArticleContent(article),
      ),
    );
  }
}
