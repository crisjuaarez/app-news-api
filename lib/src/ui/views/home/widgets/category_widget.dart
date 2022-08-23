import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_news_api/src/ui/theme/my_colors.dart';
import 'package:app_news_api/src/ui/views/home/home_provider.dart';
import 'package:app_news_api/src/domain/models/category_model.dart';
import 'package:app_news_api/src/domain/providers/news_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = context.read<HomeProvider>();
    final Category category = apiCategories[index];
    final bool selected = homeProvider.pageCtrl.page!.toInt() == index;

    return GestureDetector(
      onTap: () async {
        homeProvider.jumpTo(index);

        await context.read<NewsProvider>().getArticlesByCategoryConditionally(
              category.searchValue,
            );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1250),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selected ? MyColors.blue : Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        alignment: Alignment.center,
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : MyColors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
