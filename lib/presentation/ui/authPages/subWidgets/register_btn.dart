import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class RegisterBtn extends StatelessWidget {
  bool get isCreate => RM.get<AuthStore>().state.authMode == AuthMode.register;
  final RMKey<AuthStore> authKey = RMKey();
  onError(c, e) {
    if (e.toString().contains('activ')) {
     return AlertDialogs.failed(context: c, content: e.toString()).then((value) {
        if (value == true)
          RM.get<AuthStore>().setState((s) => s.resendPhoneVerify()).then((value) =>
              ExtendedNavigator.rootNavigator.pushNamed(Routes.verifyPage));
      });
      
    } else
      print('$e');
    AlertDialogs.failed(context: c, content: e.toString());
  }

  onData(c, d) {
    ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
        isCreate ? Routes.verifyPage : Routes.mainPage, (route) => false);
  }

  authenticate() => RM.get<AuthStore>().setState(
        (s) => isCreate ? s.register() : s.login(),
        onError: onError,
        onData: onData,
      );
  Gestures gesture() => Gestures()..onTap(authenticate);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = TxtStyle()
      ..textColor(Colors.white)
      ..background.color(Colors.amber)
      ..borderRadius(all: 16)
      ..alignmentContent.center()
      ..width(size.width * 0.5)
      ..height(size.height / 16)
      ..margin(top: 24)
      ..fontSize(19);
    return Txt(
      isCreate ? "تسجيل" : "دخول",
      style: textStyle,
      gesture: gesture(),
    );
  }
}
