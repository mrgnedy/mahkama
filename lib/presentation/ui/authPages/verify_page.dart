import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

class VerifyPage extends StatelessWidget {
  final bool isForget;
  final txtStyle = TxtStyle()
    ..fontSize(20)
    ..textColor(ColorsD.main);

  VerifyPage({Key key, this.isForget = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_LOGO_PNG,
                  height: size.height / 6,
                  width: size.width * 0.72,
                ),
                SizedBox(height: size.height / 20),
                Txt('أرسل رمز التحقق المرسل إليك', style: txtStyle),
                _BuildVerify(isForget: isForget),
                SizedBox(height: size.height / 20),
                _BuildResend(isForget: isForget == true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildVerify extends StatelessWidget {
  final bool isForget;
  RMKey<AuthStore> _rmKey = RMKey();

  _BuildVerify({Key key, this.isForget = false}) : super(key: key);
  verify(value) => _rmKey.setState(
      (s) => isForget ? s.verifyForgetPassword(value) : s.phoneVerify(value),
      onError: onError,
      onData: onData);
  onError(BuildContext c, e) {
    print(e);
    AlertDialogs.failed(context: c, content: "من فضلك أدخل الكود بشكل صحيح");
  }

  onData(c, d) {
    ExtendedNavigator.rootNavigator
        .pushNamed(isForget ? Routes.rechangePage : Routes.mainPage);
  }

  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      rmKey: _rmKey,
      observe: () => RM.get<AuthStore>(),
      onIdle: () => _BuildVerifyOnData(callback: verify),
      onWaiting: () => WaitingWidget(),
      onError: (e) => _BuildVerifyOnData(callback: verify, hasError: true),
      onData: (d) => _BuildVerifyOnData(callback: verify),
    );
  }
}

class _BuildVerifyOnData extends StatelessWidget {
  final bool hasError;
  final Function callback;

  const _BuildVerifyOnData({Key key, this.hasError = false, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _BuildPinCode(callback: callback),
        _BuildConfirm(hasError: hasError == true, callback: callback),
      ],
    );
  }
}

class _BuildPinCode extends StatelessWidget {
  final Function callback;
  String enteredPin;

  _BuildPinCode({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.65,
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height / 20),
          PinCodeTextField(
            length: 4,
            onChanged: (pin) => enteredPin = pin,
            onCompleted: callback,
            backgroundColor: Colors.transparent,
            pinTheme: PinTheme(
              inactiveColor: ColorsD.main.withAlpha(64),
              selectedColor: Colors.amber,
              activeColor: ColorsD.main,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(height: size.height / 20),
        ],
      ),
    );
  }

  // verify(value) => RM.get<AuthStore>().setState(
  //     (s) => isForget ? s.verifyForgetPassword(value) : s.phoneVerify(value),
  //     onError: onError,
  //     onData: onData);
  // onError(BuildContext c, e) {
  //   print(e);
  //   AlertDialogs.failed(context: c, content: "من فضلك أدخل الكود بشكل صحيح");
  // }

  // onData(c, d) {
  //   ExtendedNavigator.rootNavigator
  //       .pushNamed(isForget ? null : Routes.mainPage);
  // }
}

class _BuildConfirm extends StatelessWidget {
  final bool hasError;
  final Function callback;

  const _BuildConfirm({Key key, this.hasError = false, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gesture = Gestures()..onTap(() => callback('1111'));
    final style = TxtStyle()
      ..fontSize(18)
      ..textColor(Colors.white)
      ..alignmentContent.center()
      ..borderRadius(all: 12)
      ..background.color(hasError ? Colors.red : Colors.amber)
      ..width(size.width * 0.45)
      ..height(size.height / 16);
    return Txt(
      hasError ? "اعد المحاولة" : 'تأكيد',
      style: style,
      gesture: gesture,
    );
  }
}

class _BuildResend extends StatelessWidget {
  final bool isForget;
  RMKey<AuthStore> _rmKey = RMKey();

  _BuildResend({Key key, this.isForget}) : super(key: key);
  resendCode() => _rmKey.setState((state) =>
      isForget ? state.sendForgetPassword() : state.resendPhoneVerify());
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder<AuthStore>(
      rmKey: _rmKey,
      observe: () => RM.get<AuthStore>(),
      onData: (AuthStore data) => _BuildResendOnData(callback: resendCode),
      onError: (error) =>
          _BuildResendOnData(hasError: true, callback: resendCode),
      onIdle: () => _BuildResendOnData(callback: resendCode),
      onWaiting: () => WaitingWidget(),
    );
  }
}

class _BuildResendOnData extends StatelessWidget {
  final bool hasError;
  final Function callback;
  final style = TxtStyle()
    // ..textDecoration(TextDecoration.underline)
    ..border(bottom: 1.2, color: ColorsD.main)
    ..textColor(ColorsD.main)
    ..fontSize(18);

  _BuildResendOnData({Key key, this.hasError = false, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()..onTap(callback);
    return Txt(
      'أعد إرسال رمز التحقق مرة أخرى',
      style: style,
      gesture: gesture,
    );
  }
}
