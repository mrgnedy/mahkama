import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart' as u;
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/navigationPages/main_page.dart';
import 'package:mahkama/presentation/ui/onBoarding/build_app_bar.dart';
import 'package:division/division.dart';
import 'package:mahkama/presentation/widgets/FCM.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

class SelectAuthPage extends StatefulWidget {
  @override
  _SelectAuthPageState createState() => _SelectAuthPageState();
}

class _SelectAuthPageState extends State<SelectAuthPage> {
  Gestures loginGesture() => gesture(0);

  Gestures registerGesture() => gesture(1);

  gesture(int mode) {
    return Gestures()
      ..onTap(() {
        RM.get<AuthStore>().state.authMode = AuthMode.values[mode];
        print(RM.get<AuthStore>().state.authMode);
        ExtendedNavigator.rootNavigator.pushNamed(Routes.authPage);
      });
  }
  String deviceToken;
  getToken(String token){
    deviceToken = token;
    print(deviceToken);
    RM.get<AuthStore>().state.deviceToken = deviceToken;
    
  }
  onMessage(String msg){
    Future.delayed(Duration(milliseconds: 10), ()async{
      bool b= await u.AlertDialogs.success(context: RM.context, content: 'لديك إشعار جديد!');
      if(b ==true) {
        RM.get<PageState>().state.currentPage =0;
        ExtendedNavigator.rootNavigator.pushNamed(Routes.mainPage);}
    });
  }
  onLaunch(String msg){
    Future.delayed(Duration(milliseconds: 10), ()async{
        RM.get<PageState>().state.currentPage =0;
        ExtendedNavigator.rootNavigator.pushNamed(Routes.mainPage);
    });
  }
  onResume(String msg){
    Future.delayed(Duration(milliseconds: 10), ()async{
        RM.get<PageState>().state.currentPage =0;
        ExtendedNavigator.rootNavigator.pushNamed(Routes.mainPage);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    FirebaseNotifications.handler(onMessage, onLaunch, onResume);
    // FirebaseNotifications.getToken(getToken);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final registerStyle = TxtStyle()
      ..width(size.width * 0.75)
      ..height(size.height / 14)
      ..borderRadius(all: 12)
      ..background.color(Colors.amber)
      ..fontSize(22)
      ..textColor(Colors.white)
      ..alignmentContent.center();

    final loginStyle = registerStyle.clone()
      ..background.color(Colors.teal[900]);
    return Scaffold(
          body: Center(
        heightFactor: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BuildAppBar(height: size.height / 6),
            SizedBox(height: size.height / 20),
            Txt('تسجيل جديد', style: registerStyle, gesture: registerGesture()),
            SizedBox(height: size.height / 40),
            Txt('تسجيل دخول', style: loginStyle, gesture: loginGesture())
          ],
        ),
      ),
    );
  }
}
