import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  late PageController pageCtrl;
  late TextEditingController searchCtrl;

  bool isSearching = false;
  void toggleSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void jumpTo(int index) {
    pageCtrl.jumpToPage(index);
    notifyListeners();
  }
}
