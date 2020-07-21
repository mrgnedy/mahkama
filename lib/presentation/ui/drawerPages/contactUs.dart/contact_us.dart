import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/send_msg_model.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/widgets/tet_field_with_title.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          height: RM.mediaQuery.size.height / 8,
          title: "تواصل معنا",
        ),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  onChangingName(String s) {
    RM.get<AuthStore>().state.sendMsgModel.name = s;
  }

  onChangingMsg(String s) {
    RM.get<AuthStore>().state.sendMsgModel.msg = s;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
          heightFactor: 1,
          child: Column(
      children: <Widget>[
          TetFieldWithTitle(
            title: 'الإسم',
            onChanging: onChangingName,
          ),
          TetFieldWithTitle(
            title: 'اترك رسالتك',
            onChanging: onChangingMsg,
            minLines: 6,
          ),
          SizedBox(height: RM.mediaQuery.size.height*0.03),
          _BuildSendMsg()
      ],
    ),
        ));
  }
}

class _BuildSendMsg extends StatelessWidget {
  RMKey<AuthStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      rmKey: _rmKey,
      observe: () => RM.get<AuthStore>(),
      onIdle: () => _BuildSendMsgOnData(),
      onWaiting: () => WaitingWidget(),
      onError: (e) => _BuildSendMsgOnData(),
      onData: (d) => _BuildSendMsgOnData(),
    );
  }
}

class _BuildSendMsgOnData extends StatelessWidget {
  SendMsgModel get sendMsgModel => RM.get<AuthStore>().state.sendMsgModel;
  onError(c, e) {
    if (sendMsgModel.name == null || sendMsgModel.name.isEmpty)
      AlertDialogs.failed(content: 'من فضلك أدخل اسمك', context: c);
    else if (sendMsgModel.msg == null || sendMsgModel.msg.isEmpty)
      AlertDialogs.failed(content: 'من فضلك أدخل نص رسالتك',context: c);
    else {
      print(e);
      AlertDialogs.failed(content: 'تعذر ارسال رسالتك, من فضلك أعد المحاولة',context: c);
    }
  }

  onData(c, d) {
    ExtendedNavigator.rootNavigator.pop();
  }

  final style = TxtStyle()
    ..borderRadius(all: 12)
    ..alignmentContent.center()
    ..fontSize(18)
    ..background.color(Colors.amber)
    ..width(RM.mediaQuery.size.width * 0.5)
    ..height(RM.mediaQuery.size.height / 16);
  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()
      ..onTap(() {
        RM
            .get<AuthStore>()
            .setState((s) => s.contactUs(), onData: onData, onError: onError);
      });
    return Txt('إرسال', style: style, gesture: gesture);
  }
}
