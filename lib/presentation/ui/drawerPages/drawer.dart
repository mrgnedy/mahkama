import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

class DrawerPage extends StatelessWidget {
  Gestures myOccassionsNav() => Gestures()
    ..onTap(() =>
        ExtendedNavigator.rootNavigator.pushNamed(Routes.myOccassionsPage));
  Gestures contactUsPage() => Gestures()
    ..onTap(() => ExtendedNavigator.rootNavigator.pushNamed(Routes.contactUs));

  Gestures logOut() => Gestures()
    ..onTap(() {
      RM.get<AuthStore>().state.credentialModel = null;
      RM.get<AuthStore>().state.pref.clear();
      ExtendedNavigator.rootNavigator
          .pushNamedAndRemoveUntil(Routes.selectAuthPage, (route) => false);
    });

  Gestures navigateToAbout(String key, String title) => Gestures()
    ..onTap(() {
      ExtendedNavigator.rootNavigator.pushNamed(
          Routes.aboutPage,arguments: AboutPageArguments(title: title, jsonKey: key));
    });

  GlobalKey<DrawerControllerState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = TxtStyle()
      ..fontSize(24)
      ..textColor(ColorsD.main)
      ..margin(bottom: 20)
      ..textAlign.center();
    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        size: Size(size.height, size.width),
        painter: _CustomDrawer(size.height, size.width),
        child: Align(
          alignment: Alignment(0.8, -.4),
          // heightFactor: 0.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image.asset(R.ASSETS_IMAGES_LOGO_PNG, width: size.width * 0.45),
              SizedBox(height: size.width * 0.15),
              Txt('مناسباتى', style: style, gesture: myOccassionsNav()),
              Txt('تواصل معنا', style: style, gesture: contactUsPage()),
              Txt('الخصوصية',
                  style: style,
                  gesture: navigateToAbout('Privacy', 'الخصوصية')),
              Txt('من نحن',
                  style: style, gesture: navigateToAbout('who', 'من نحن')),
              Txt('الشروط والأحكام',
                  style: style,
                  gesture: navigateToAbout('conditions', 'الشروط والأحكام')),
              Txt('تسجيل الخروج', style: style, gesture: logOut()),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDrawer extends CustomPainter {
  final double height;
  final double width;

  _CustomDrawer(this.height, this.width);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Path path = Path()
      ..moveTo(width * 0.3, 0)
      ..quadraticBezierTo(width * 0.6, height / 2, width * 0.3, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..lineTo(width * 0.3, 0)
      ..close();
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
