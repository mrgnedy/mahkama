import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class DevWallet extends StatelessWidget {
  final String title;

  const DevWallet({Key key, this.title = "محفظة التطوير الإثرائى"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: BuildAppBar(height: size.height / 8, title: title),
            body: _BuildBody()));
  }
}

class _BuildBody extends StatelessWidget {
    final rm = RM.get<OccassionsStore>()..state.currentCatID='5'..resetToIdle();
  RMKey<OccassionsStore> _rmKey = RMKey();
  bool get hasData => _rmKey.state.currentCategories != null;
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder<OccassionsStore>(
      observe: () => rm,
      // dispose: (_, __) => rm.state.currentCatID = null,
      rmKey: _rmKey,
      onIdle: () => Container(),
      onWaiting: () =>  WaitingWidget(),
      onError: (e) =>  Center(child: Txt('فشلت العملية')),
      onData: (d) => _OnData(linkList: d.currentCategories.data),
      initState: (_, rm) => _rmKey.setState((s)=>s.getCategoryByID())
      
    );
  }
}

class _OnData extends StatelessWidget {
final List<SubCatTypeTwo> linkList;

  const _OnData({Key key, this.linkList}) : super(key: key);
  // List get linkList =>
  //     RM.get<OccassionsStore>().state.currentCategories?.data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
              linkList.length,
              (index) => _DetailWithLink(
                  label: linkList[index].name, link: linkList[index].link)),
        ),
      ),
    );
  }
}

class _DetailWithLink extends StatelessWidget {
  final String label;
  final String link;
  _DetailWithLink(
      {Key key,
      this.label = "إسم الدورة التطويرية",
      this.link = "www.google.com"})
      : super(key: key);
  final labelStyle = TxtStyle()
    ..fontSize(18)
    ..textColor(ColorsD.main);
  final linkStyle = TxtStyle()
    ..fontSize(14)
    ..textColor(Colors.black)
    ..border(bottom: 1);
  Gestures gesture() => Gestures()..onTap(openUrl);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Txt('$label', style: labelStyle),
          Txt('$link', style: linkStyle, gesture: gesture()),
          SizedBox(height: size.height * 0.02)
        ],
      ),
    );
  }

  openUrl() async {
    if (await canLaunch("http://$link")) await launch("http://$link");
  }
}
