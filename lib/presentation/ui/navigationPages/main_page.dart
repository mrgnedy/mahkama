import 'package:flutter/material.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/navigationPages/homeCategories/home_categories.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'notification/notification_page.dart';
import 'profile/profile_page.dart';

class PageState {
  int currentPage = 1;
  PageController pageCtrler;
  PageState() {
    pageCtrler = PageController(initialPage: currentPage);
  }
}

class MainPage extends StatelessWidget {
  final pages = [
    ProfilePage(),
    HomeCategoriesPage(),
    NotificationPage(),
  ];
  Widget get currentPage => pages[RM.get<PageState>().state.currentPage];
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.78,
        child: PageView(
          children: pages,
          controller: RM.get<PageState>().state.pageCtrler,
        ),
      );
    });
    // return WhenRebuilder(
    //   onIdle: () => currentPage,
    //   onWaiting: () => currentPage,
    //   onError: (e) => currentPage,
    //   onData: (d) => currentPage,
    //   // rmKey: RM.get<AuthStore>().state.pageKey,
    //   observe: () => RM.get<PageState>(),
    // );
  }
}
