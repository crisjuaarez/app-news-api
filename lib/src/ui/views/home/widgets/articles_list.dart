import 'package:flutter/material.dart';

import 'package:app_news_api/src/ui/utils/responsive.dart';
import 'package:app_news_api/src/domain/models/article_model.dart';

import 'article_widget.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({
    Key? key,
    required this.articles,
    required this.currentCategory,
  }) : super(key: key);

  final List<Article> articles;
  final String currentCategory;

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Responsive responsive = Responsive.of(context);
    return ListView.separated(
      itemCount: widget.articles.length,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.wp(4),
        vertical: responsive.hp(8),
      ),
      itemBuilder: (_, i) {
        final article = widget.articles[i];
        if (article.category == widget.currentCategory) {
          return ArticleWidget(article);
        }
        return const SizedBox.shrink();
      },
      separatorBuilder: (_, i) =>
          widget.articles[i].category == widget.currentCategory
              ? SizedBox(height: responsive.hp(2))
              : const SizedBox.shrink(),
    );
  }
}
