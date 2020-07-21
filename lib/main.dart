import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/navigationPages/main_page.dart';
import 'package:mahkama/router.gr.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'presentation/ui/onBoarding/onBoardingPage.dart';
import 'presentation/ui/authPages/auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject(() => OccassionsStore(), isLazy: false),
          Inject(() => AuthStore(), isLazy: false),
          Inject(() => PageState())
        ],
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'المحكمة',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  button: TextStyle(fontFamily: 'bein'),
                  overline: TextStyle(fontFamily: 'bein'),
                  caption: TextStyle(fontFamily: 'bein'),
                  bodyText1: TextStyle(fontFamily: 'bein'),
                  bodyText2: TextStyle(fontFamily: 'bein'),
                  headline1: TextStyle(fontFamily: 'bein'),
                  headline2: TextStyle(fontFamily: 'bein'),
                  headline3: TextStyle(fontFamily: 'bein'),
                  headline4: TextStyle(fontFamily: 'bein'),
                  headline5: TextStyle(fontFamily: 'bein'),
                  headline6: TextStyle(fontFamily: 'bein'),
                  subtitle1: TextStyle(fontFamily: 'bein'),
                  subtitle2: TextStyle(fontFamily: 'bein'),
                  
                )),
            builder: ExtendedNavigator(router: Router()),
          );
        });
  }
}
