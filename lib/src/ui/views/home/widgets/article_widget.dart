import 'package:flutter/material.dart';

import 'package:app_news_api/src/ui/utils/router.dart';
import 'package:app_news_api/src/ui/utils/responsive.dart';
import 'package:app_news_api/src/domain/helpers/validators.dart';
import 'package:app_news_api/src/ui/widgets/my_network_image.dart';
import 'package:app_news_api/src/domain/models/article_model.dart';

import '../../detail/detail_view.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget(this.article, {Key? key}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final bool isValidImage = Validators.networkImage(article.urlToImage);

    return GestureDetector(
      onTap: () => MyRouter.goTo(context, DetailView(article)),
      child: isValidImage
          ? SizedBox(
              width: double.infinity,
              height: responsive.hp(35),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: article.urlToImage! + article.category,
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.10),
                          BlendMode.darken,
                        ),
                        child: MyNetworkImage(
                          article.urlToImage!,
                          height: responsive.hp(35),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(4),
                        vertical: responsive.hp(2),
                      ),
                      child: Text(
                        article.title,
                        style: TextStyle(
                          fontSize: responsive.dp(2),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.5, 0.5),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListTile(
              title: Text(
                article.title,
                style: TextStyle(
                  fontSize: responsive.dp(2),
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                article.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: responsive.dp(1.75),
                  color: Colors.grey.shade500,
                ),
              ),
            ),
    );
  }
}
