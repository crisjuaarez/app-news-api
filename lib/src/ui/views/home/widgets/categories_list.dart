import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_provider.dart';
import 'category_widget.dart';
import 'package:app_news_api/src/ui/utils/responsive.dart';
import 'package:app_news_api/src/domain/models/category_model.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
      child: SizedBox(
        height: responsive.hp(5),
        width: double.infinity,
        child: Consumer<HomeProvider>(
          builder: (_, provider, __) => ListView.separated(
            shrinkWrap: true,
            itemCount: apiCategories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: responsive.wp(4)),
            itemBuilder: (_, i) => CategoryWidget(i),
            separatorBuilder: (_, __) => SizedBox(width: responsive.wp(2)),
          ),
        ),
      ),
    );
  }
}
