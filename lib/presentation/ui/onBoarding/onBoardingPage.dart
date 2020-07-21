import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/authPages/auth_page.dart';
import 'package:mahkama/presentation/ui/mainSections/home_page.dart';
import 'package:mahkama/presentation/ui/navigationPages/main_page.dart';
import 'package:mahkama/presentation/ui/onBoarding/skip_bottom_sheet.dart';
import 'package:mahkama/presentation/ui/onBoarding/video_page.dart';
import 'package:mahkama/presentation/ui/authPages/select_auth.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  CrossFadeState pageState = CrossFadeState.showFirst;

  callbackAction() {
    pageState = CrossFadeState.values[1 - pageState.index];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Builder(
            builder: (context) {
              return AnimatedCrossFade(
                crossFadeState: pageState,
                duration: Duration(milliseconds: 500),
                firstChild: IntroVideoPage(),
                secondChild: SelectAuthPage(),
              );
            },
          ),
        ),
        bottomSheet: BuildButtomSheet(
          callBack: callbackAction,
          state: pageState,
        ),
      ),
    );
  }
}

class OnBoardingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG));
  }
}
