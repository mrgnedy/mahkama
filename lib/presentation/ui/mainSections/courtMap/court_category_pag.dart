import 'dart:math';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactType { whatsApp, mail, phone }

class CourtCategoryPage extends StatelessWidget {
  final String title;
  final String specs;
  final String mail;
  final String whatsApp;

  CourtCategoryPage(
      {Key key,
      this.title = "الكابير",
      this.specs =
          "هذاالنص هو عبارة عن تجربة لحجم النص مكتوب للتعبير عن الانجازات التى حققتها وزارة العدل فى مجال صرف المعاشات و توفير فرص العمل للخيريجن تحت سن الثمانين وكلام فاضي كتير كدة",
      this.mail = "mail@gmail.com",
      this.whatsApp = "+07775000"})
      : super(key: key);

  bool get hasData =>
      RM.get<OccassionsStore>().state.currentSubCategories != null;
  RMKey<OccassionsStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(title: title, height: size.height / 8),
        body: WhenRebuilder<OccassionsStore>(
            initState: (_, __) => _rmKey.setState((s) => s.getSubCategoryByID(),
                onError: (ctx, error) => print('THIS IS ERROR $e')),
            rmKey: _rmKey,
            dispose: (_, store) => store.state.currentSubCategories = null,
            onIdle: () => _OnData(),
            onWaiting: () => hasData ? _OnData() : WaitingWidget(),
            onError: (e) => hasData ? _OnData() : Txt('فشلت العملية'),
            onData: (d) => _OnData(),
            observe: () => RM.get<OccassionsStore>()),
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  List get data =>
      RM.get<OccassionsStore>().state.currentSubCategories?.data;
  final titleStyle = TxtStyle()
    ..fontSize(18)
    ..fontWeight(FontWeight.bold)
    ..textColor(Colors.black)
    ..textAlign.right();
  final specStyle = TxtStyle()..textAlign.right();

  @override
  Widget build(BuildContext context) {
    return data == null || data.isEmpty
        ? Center(
            child: Txt('لا توجد بيانات'),
          )
        : SingleChildScrollView(
            child: Center(
              child: Container(
                width: RM.mediaQuery.size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Txt('اختصاصه', style: titleStyle),
                    Txt('${data.first.text}', style: specStyle),
                    SizedBox(height: RM.mediaQuery.size.height * 0.06),
                    Txt('للتواصل مع القسم', style: titleStyle),
                    _BuildContactDetails(
                        icon: Icons.mail_outline,
                        label: '${data.first.email}',
                        type: ContactType.mail),
                    _BuildContactDetails(
                        icon: FontAwesomeIcons.whatsappSquare,
                        label: '${data.first.phone1}',
                        type: ContactType.whatsApp),
                    _BuildContactDetails(
                        icon: FontAwesomeIcons.phoneSquareAlt,
                        label: '${data.first.phone2}',
                        type: ContactType.phone),
                  ],
                ),
              ),
            ),
          );
  }
}

class _BuildContactDetails extends StatelessWidget {
  final String label;
  final IconData icon;
  final ContactType type;

  var asset;

  _BuildContactDetails({Key key, this.label, this.icon, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: contactCallback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Txt(label),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: ColorsD.main),
          ),
        ],
      ),
    );
  }

  List<String> contacts() => [
        'whatsapp://send?phone=/$label',
        'mailto:$label',
        'tel:$label',
      ];
  contactCallback() async {
    if (await canLaunch(contacts()[type.index]))
      await launch(contacts()[type.index]);
  }
}
