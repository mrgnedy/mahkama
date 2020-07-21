import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/credentials_model.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/widgets/tet_field_with_title.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
// import 'package:mahkama/data/models/';

class ProfilePage extends StatefulWidget {
  ProfilePage() {
    RM.get<AuthStore>().state.authModel =
        RM.get<AuthStore>().state.credentialModel?? CredentialModel(data: Credentials());
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  bool isEdit = false;
  allowEditProfile() {
    isEdit = !isEdit;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final profileInfo = [
      {"key": "first_name", "label": "الإسم الأول"},
      {"key": "last_name", "label": "الإسم الأخير"},
      {"key": "email", "label": "البريد الإلكترونى"},
      // {"key": "password", "label": "كلمة المرور"},
    ];
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          _AllowEdit(callback: allowEditProfile),
          ...profileInfo
              .map<Widget>(
                (e) => _ProfileDetail(detail: e, isEdit: isEdit),
              )
              .toList(),
          _ConfirmEdit(isEdit: isEdit),
        ]),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}

class _ProfileDetail extends StatelessWidget {
  final Map detail;
  final bool isEdit;

  final ctrler = TextEditingController();

  _ProfileDetail({Key key, this.detail, this.isEdit}) : super(key: key);
  onChange(String s) {
    final map = RM.get<AuthStore>().state.authModel.data.toJson()
      ..[detail['key']] = s;
    RM.get<AuthStore>().state.authModel.data = Credentials.fromJson(map);
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    final style = ParentStyle()
      ..height(MediaQuery.of(context).size.height / 6.2)
      ..border(all: 1, color: ColorsD.main)
      ..borderRadius(all: 12)
      ..padding(all: 8)
      ..margin(all: 5)
      ..width(MediaQuery.of(context).size.width * 0.8);
    ctrler.text =
        RM.get<AuthStore>().state.credentialModel.data.toJson()[detail['key']];
    return Parent(
        style: style,
        child: TetFieldWithTitle(
            title: detail['label'],
            isEditable: isEdit,
            onChanging: onChange,
            textEditingController: ctrler));
  }
}

class _ConfirmEdit extends StatelessWidget {
  final bool isEdit;
  final rm = RM.get<AuthStore>();
  RMKey<AuthStore> _rmKey = RMKey();

   _ConfirmEdit({Key key, this.isEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isEdit,
          child: WhenRebuilder(
        rmKey: _rmKey,
        observe: () => rm,
        onIdle: () => _ConfirmEditOnData(),
        onWaiting: () => WaitingWidget(),
        onError: (e) => _ConfirmEditOnData(),
        onData: (d) => _ConfirmEditOnData(),
      ),
    );
  }
}

class _ConfirmEditOnData extends StatelessWidget {
  final gesture = Gestures()
    ..onTap(() {
      RM.get<AuthStore>().setState((s) => s.editProfile());
    });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = TxtStyle()
      ..width(size.width * 0.45)
      ..height(size.height / 16)
      ..fontSize(20)
      ..margin(top: 12)
      ..alignmentContent.center()
      ..borderRadius(all: 12)
      ..background.color(Colors.amber)
      ..textColor(Colors.white)
      ..fontWeight(FontWeight.bold);
    return Txt(
      'تعديل',
      style: style,
      gesture: gesture,
    );
  }
}

class _AllowEdit extends StatelessWidget {
  final Function callback;

  const _AllowEdit({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: callback),
          Txt('تعديل البيانات')
        ],
      ),
    );
  }
}
