import 'package:app_news_api/src/ui/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData themeData() {
    return ThemeData(
      appBarTheme: appBarTheme(),
      primaryColor: MyColors.blue,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MyColors.blue),
    );
  }

  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
