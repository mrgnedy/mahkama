import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:division/division.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/authPages/subWidgets/register_btn.dart';
import 'package:mahkama/presentation/ui/authPages/subWidgets/section_dropdown.dart';
import 'package:mahkama/presentation/ui/authPages/subWidgets/text_input_fields.dart';
import 'package:mahkama/presentation/widgets/FCM.dart';
import 'package:mahkama/presentation/widgets/tet_field_with_title.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:mahkama/data/models/credentials_model.dart';
import '../../../router.gr.dart';
import 'subWidgets/auth_appBar.dart';

class AuthPage extends StatelessWidget {
  // bool isCreate = true;
  final rm = RM.get<AuthStore>();
  String deviceToken;
  getToken(String token) {
    deviceToken = token;
    print(deviceToken);
    RM.get<AuthStore>().state.deviceToken = deviceToken;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BuildAuthAppBar(height: size.height / 4),
      body: WhenRebuilder(
        initState: (_, __) => {FirebaseNotifications.getToken(getToken), rm.state.authModel = CredentialModel(data: Credentials()) },
        observe: () => rm,
        onIdle: () => _OnData(),
        onWaiting: () => _OnData(),
        onError: (e) => _OnData(),
        onData: (d) => _OnData(),
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BuildFirstName(),
            BuildLastName(),
            BuildEmail(),
            BuildPassword(),
            BuildConfirmPW(),
            SectionDropDownBtn(),
            RegisterBtn(),
            _HaveAccountQuestion(),
            _ForgotPassword()
          ],
        ),
      ),
    );
  }
}

// class _BuildDropDownBtn extends StatefulWidget {
//   // final List<_Section> sections;
//   final Function callback;
//   String selectedSec;

//   _BuildDropDownBtn({Key key, this.sections, this.callback, this.selectedSec})
//       : super(key: key);
//   @override
//   __BuildDropDownBtnState createState() => __BuildDropDownBtnState();
// }

// class __BuildDropDownBtnState extends State<_BuildDropDownBtn> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//         underline: Container(),
//         isExpanded: true,
//         icon: Icon(Icons.arrow_drop_down, color: Colors.amber),
//         value: widget.selectedSec,
//         items: widget.sections
//             .map((section) => DropdownMenuItem(
//                   child: Txt(section.section),
//                   value: section.section,
//                 ))
//             .toList(),
//         onChanged: (sec) {
//           setState(() {
//             widget.selectedSec = sec;
//             widget.callback(1, sec);
//           });
//         });
//   }
// }

class _HaveAccountQuestion extends StatelessWidget {
  bool get isCreate => RM.get<AuthStore>().state.authMode == AuthMode.register;
  final style = TxtStyle()
    ..textColor(ColorsD.main)
    ..alignmentContent.center()
    ..alignment.center()
    ..margin(bottom: 24);
  changeisCreateCallback() => RM
      .get<AuthStore>()
      .setState((s) => s.authMode = AuthMode.values[1 - s.authMode.index]);
  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()..onTap(() => changeisCreateCallback());
    // TODO: implement build
    return Txt(
        isCreate ? 'لديك حساب؟ تسجيل الدخول' : "ليس لديك حساب؟ تسجيل جديد",
        style: style,
        gesture: gesture);
  }
}

class _ForgotPassword extends StatelessWidget {
  bool get isCreate => RM.get<AuthStore>().state.authMode == AuthMode.register;
  final style = TxtStyle()
    ..textColor(ColorsD.main)
    ..alignmentContent.center();
  final gesture = Gestures()
    ..onTap(() {
      print(Routes.forgetPasswordPage);
      ExtendedNavigator.rootNavigator.pushNamed(Routes.forgetPasswordPage);
    });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isCreate,
      child: Txt('نسيت كلمة المرور؟', style: style, gesture: gesture),
    );
  }
}
