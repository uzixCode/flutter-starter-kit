import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PageLogic extends PagesCubit {
  PageController pageController = PageController();
  int currentIndex = 0;
  void changeIndex(int index, [bool? changePage]) {
    currentIndex = index;
    log(index.toString());
    refresher();
    if (changePage == true && pageController.hasClients) {
      pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }
}
