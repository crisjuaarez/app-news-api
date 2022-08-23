import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_news_api/src/ui/utils/responsive.dart';
import 'package:app_news_api/src/ui/widgets/circular_icon.dart';
import 'package:app_news_api/src/domain/models/article_model.dart';
import 'package:app_news_api/src/domain/providers/news_provider.dart';

import '../home/widgets/article_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late Future<List<Article>> _futureSearchResult;
  @override
  void initState() {
    super.initState();
    _futureSearchResult =
        context.read<NewsProvider>().getArticlesByQuery(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
          leading: CircularIcon(
            icon: Icons.chevron_left,
            onTap: () => Navigator.maybePop(context),
          ),
          title: Text('Resultados de "${widget.query}"')),
      body: FutureBuilder<List<Article>>(
        future: _futureSearchResult,
        initialData: const [],
        builder: (_, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(
                horizontal: responsive.wp(4),
                vertical: responsive.hp(2),
              ),
              itemBuilder: (_, i) {
                final article = snapshot.data![i];
                return ArticleWidget(article);
              },
              separatorBuilder: (_, __) => SizedBox(
                height: responsive.hp(2),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
