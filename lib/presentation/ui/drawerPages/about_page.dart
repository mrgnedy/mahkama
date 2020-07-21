import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AboutPage extends StatelessWidget {
  final String title;
  final String jsonKey;
  final rmState = RM.get<AuthStore>().state;
  AboutPage({Key key, this.title, this.jsonKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('HELLO ${rmState.credentialModel.toJson()}');
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: BuildAppBar(height: size.height / 8, title: title),
      body: _Body(jsonKey: jsonKey),
    ));
  }
}

class _Body extends StatelessWidget {
  final jsonKey;
  final rm = RM.get<AuthStore>();

  _Body({Key key, this.jsonKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return WhenRebuilder(
      observe: () => rm,
      initState: (_, model) => rm.setState((s) => s.getSettings()),
      onData: (data) => _BuildBody(jsonKey: jsonKey),
      onError: (error) => Center(child: Txt('لا توجد بيانات')),
      onIdle: () => _BuildBody(jsonKey: jsonKey),
      onWaiting: () => WaitingWidget(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  final String jsonKey;
  final rmState = RM.get<AuthStore>().state;

  _BuildBody({Key key, this.jsonKey}) : super(key: key);
  String get info =>
      rmState.settingsModel?.data?.first?.toJson()['$jsonKey']?.toString();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Center(child: Txt(info)));
  }
}
