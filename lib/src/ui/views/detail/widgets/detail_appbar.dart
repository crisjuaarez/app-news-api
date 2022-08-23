import 'package:flutter/material.dart';

import 'package:app_news_api/src/ui/utils/responsive.dart';
import 'package:app_news_api/src/ui/widgets/circular_icon.dart';
import 'package:app_news_api/src/domain/helpers/validators.dart';
import 'package:app_news_api/src/ui/widgets/my_network_image.dart';
import 'package:app_news_api/src/domain/models/article_model.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar(this.article, {Key? key}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double articleSize = responsive.hp(55);
    final bool isValidImage = Validators.networkImage(article.urlToImage);

    return SliverAppBar(
      expandedHeight: isValidImage ? articleSize : null,
      leading: CircularIcon(
        onTap: () => Navigator.maybePop(context),
        icon: Icons.chevron_left,
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        title: Material(
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            child: Text(
              article.source.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        background: isValidImage
            ? Hero(
                tag: article.urlToImage! + article.category,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  child: MyNetworkImage(
                    article.urlToImage!,
                    height: articleSize * 1.25,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
