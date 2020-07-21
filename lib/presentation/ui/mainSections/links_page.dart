import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksPage extends StatelessWidget {
  final String title;

  const LinksPage({Key key, this.title}) : super(key: key);
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
  RMKey<OccassionsStore> _rmKey = RMKey();
  bool get hasData => _rmKey.state.currentSubCategories != null;
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      observe: () => RM.get<OccassionsStore>(),
      rmKey: _rmKey,
      dispose: (_, __) => _rmKey.state.currentCatID = null,
      onIdle: () => _OnData(),
      onWaiting: () => hasData ? _OnData() : WaitingWidget(),
      onError: (e) => hasData ? _OnData() : Center(child: Txt('فشلت العملية')),
      onData: (d) => _OnData(),
      initState: (_, __) => _rmKey.setState((s) => s.getSubCategoryByID()),
    );
  }
}

class _OnData extends StatelessWidget {
  List get linkList =>
      RM.get<OccassionsStore>().state.currentSubCategories.data;
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
