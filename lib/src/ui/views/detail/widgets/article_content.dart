import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:app_news_api/src/ui/theme/my_colors.dart';
import 'package:app_news_api/src/ui/utils/responsive.dart';
import 'package:app_news_api/src/domain/models/article_model.dart';

class ArticleContent extends StatelessWidget {
  const ArticleContent(this.article, {Key? key}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.wp(4),
          vertical: responsive.hp(2),
        ),
        child: Column(
          children: [
            Text(
              article.title,
              style: TextStyle(
                fontSize: responsive.dp(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              article.description,
              style: TextStyle(
                fontSize: responsive.dp(2),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Divider(),
            Text(
              article.content,
              style: TextStyle(
                fontSize: responsive.dp(2),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: responsive.hp(2)),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                child: const Text(
                  'Mostrar artículo completo',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: MyColors.blue,
                  ),
                ),
                onPressed: () async => await launchUrlString(article.url),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
