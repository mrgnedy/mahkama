import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/authPages/auth_page.dart';
import 'package:mahkama/presentation/widgets/tet_field_with_title.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';
import 'subWidgets/auth_appBar.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BuildAuthAppBar(
              height: RM.mediaQuery.size.height / 4,
              title: 'نسيت كلمة المرور؟',
            ),
            body: _BuildBody()));
  }
}

class _BuildBody extends StatelessWidget {
  onChange(String s) {
    RM.get<AuthStore>().state.authModel.data.email = s;
  }

  final resendStyle = TxtStyle()
    ..textColor(Colors.blue)
    ..border(bottom: 1, color: Colors.blue);
  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TetFieldWithTitle(
              title: "أدخل البريد الالكترونى",
              onChanging: onChange,
            ),
            SizedBox(height: RM.mediaQuery.size.height*0.03),
            _SendCode(),
            SizedBox(height: RM.mediaQuery.size.height*0.03),
            Txt('إعادة ارسال رمز التحقق', style: resendStyle)
          ],
        ));
  }
}

class _SendCode extends StatelessWidget {
  RMKey<AuthStore> _rmKey = RMKey();
  onData(ctx, data) {
    ExtendedNavigator.rootNavigator.pushNamed(Routes.verifyPage,
        arguments: VerifyPageArguments(isForget: true));
  }

  onError(ctx, error) {
    print("$error");
  }

  sendVerifyCode() => _rmKey.setState((s) => s.sendForgetPassword(),
      onData: onData, onError: onError);
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
        rmKey: _rmKey,
        onIdle: () => _SendCodeOnData(callback: sendVerifyCode),
        onWaiting: () => WaitingWidget(),
        onError: (e) =>
            _SendCodeOnData(hasError: true, callback: sendVerifyCode),
        onData: (d) => _SendCodeOnData(callback: sendVerifyCode),
        observe: () => RM.get<AuthStore>());
  }
}

class _SendCodeOnData extends StatelessWidget {
  final bool hasError;
  final Function callback;
  final style = ParentStyle()
    ..width(RM.mediaQuery.size.width * 0.7)
    ..height(RM.mediaQuery.size.height / 16)
    ..background.color( Colors.amber)
    ..borderRadius(all: 12)
    ..height(RM.mediaQuery.size.height / 18);

  _SendCodeOnData({Key key, this.hasError = false, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final gesture= Gestures()..onTap(callback);
    return Parent(
      style: style,
      gesture: gesture,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Transform.rotate(
              angle: pi,
              alignment: Alignment.center,
              child: Image.asset(
                R.ASSETS_IMAGES_BACK_PNG,
                color: Colors.white,
              ),
            ),
            Txt('${hasError ? "تعذر الإرسال, أعد المحاولة" : "التحقق"}',
                style: TxtStyle()
                  ..fontSize(18)
                  ..textColor(Colors.white))
          ],
        ),
      ),
    );
  }
}
