import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/views/home/home_view.dart';
import 'ui/theme/my_theme.dart';
import 'ui/views/home/home_provider.dart';
import 'domain/providers/news_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Inject NewsProvider to use globally
    //Inyectar NewsProvider para usar globalmente (en cualquier parte de nuestra app)
    return ChangeNotifierProvider(
      create: (_) => NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData(),
        title: 'App News Api',
        //Inject HomeProvider to use only in HomeView and descendents
        //Inyectar HomeProvider para usar únicamente en HomeView y sus descendientes
        home: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          child: const HomeView(),
        ),
      ),
    );
  }
}
