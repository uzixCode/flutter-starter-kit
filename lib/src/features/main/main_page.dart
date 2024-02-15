import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:starter_kit/src/features/home/home_page.dart';
import 'package:starter_kit/src/features/profile/profile_page.dart';
import 'logic/page_logic.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.indexPage});
  final int? indexPage;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pageLogic = PageLogic();

  @override
  void initState() {
    if (widget.indexPage != null) {
      pageLogic.pageController = PageController(initialPage: widget.indexPage!);
      pageLogic.changeIndex(widget.indexPage!, true);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCubitBuilder(
      cubit: pageLogic,
      builder: (cubit) => Scaffold(
          body: PageView(controller: pageLogic.pageController, onPageChanged: (value) => cubit.changeIndex(value), children: const [
            HomePage(),
            ProfilePage()
          ]),
          bottomNavigationBar: BottomNavigationBar(currentIndex: cubit.currentIndex, onTap: (value) => cubit.changeIndex(value, true), items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ])),
    );
  }
}
