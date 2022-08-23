import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_news_api/src/ui/views/home/home_provider.dart';
import 'package:app_news_api/src/domain/models/category_model.dart';
import 'package:app_news_api/src/domain/providers/news_provider.dart';

import 'widgets/articles_list.dart';
import 'widgets/categories_list.dart';
import 'widgets/home_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    //Get articles only if my articles list is empty with default category "general"
    //Obtener artículos solo si la lista de articulos está vacía con la categoría por defecto "general"
    context.read<NewsProvider>().getArticlesByCategoryConditionally('general');

    //Inicialize my controllers
    context.read<HomeProvider>().pageCtrl = PageController();

    context.read<HomeProvider>().searchCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    //Dispose my controllers
    context.read<HomeProvider>().pageCtrl.dispose();

    context.read<HomeProvider>().searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Stack(
        children: [
          //My articles view
          PageView.builder(
            controller: context.read<HomeProvider>().pageCtrl,
            itemCount: apiCategories.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              //We need to use the consumer to refresh the view when articles are loaded
              //Necesitamos usar el consumer para refrescar la vista cuando los artículos hayan sido cargados
              return Consumer<NewsProvider>(
                builder: (_, newsProvider, __) {
                  final articles = newsProvider.articles;
                  if (articles.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async =>
                        await newsProvider.getArticlesByCategory(
                            apiCategories[index].searchValue),
                    child: ArticlesList(
                      articles: articles,
                      currentCategory: apiCategories[index].searchValue,
                    ),
                  );
                },
              );
            },
          ),

          //Categories
          const CategoriesList(),
        ],
      ),
    );
  }
}
