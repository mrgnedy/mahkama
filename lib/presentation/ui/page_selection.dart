import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/authPages/auth_page.dart';
import 'package:mahkama/presentation/ui/mainSections/home_page.dart';
import 'package:mahkama/presentation/ui/navigationPages/main_page.dart';
import 'package:mahkama/presentation/ui/onBoarding/onBoardingPage.dart';
import 'package:mahkama/presentation/ui/onBoarding/skip_bottom_sheet.dart';
import 'package:mahkama/presentation/ui/onBoarding/video_page.dart';
import 'package:mahkama/presentation/ui/authPages/select_auth.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../router.gr.dart';

class PageSelection extends StatelessWidget {
  onData(c,AuthStore d){
    ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(d.isAuth?  Routes.mainPage: Routes.onBoardingPage, (route) => false);
  }
  RMKey<AuthStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WhenRebuilder<AuthStore>(
          rmKey: _rmKey,
          initState: (_, rm) => _rmKey.setState((s) => s.getSavedCreds(), onData: onData),
          observe: () => RM.get<AuthStore>(),
          onIdle: () => Container(),
          onWaiting: () => OnBoardingSplash(),
          onError: (e) =>  OnBoardingPage(),
          onData: (d) => Container(),
        ),
      ),
    );
  }
}