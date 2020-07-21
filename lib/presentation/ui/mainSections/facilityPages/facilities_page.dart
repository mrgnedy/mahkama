import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class FacilitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: BuildAppBar(height: size.height / 8, title: "تسهيل"),
      body: _BuildBody(),
    ));
  }
}

class _BuildBody extends StatelessWidget {
  RMKey<OccassionsStore> _rmKey = RMKey();
  bool get hasData => _rmKey.state.currentCategories != null;
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder<OccassionsStore>(
      initState: (_, __) => _rmKey.setState(
        (s) => s.getCategoryByID(),
        onError: (_, e) => print('ERROR FROM FACILITY $e'),
      ),
      rmKey: _rmKey,
      observe: () => RM.get<OccassionsStore>(),
      onIdle: () => _OnData(),
      onWaiting: () => hasData ? _OnData() : WaitingWidget(),
      onError: (e) => hasData ? _OnData() : Center(child: Txt('فشلت العملية')),
      onData: (d) => _OnData(),
    );
  }
}

class _OnData extends StatelessWidget {
  List<Category> get categories =>
      RM.get<OccassionsStore>().state.currentCategories.data.reversed.toList();
  List<String> assets = [
    R.ASSETS_IMAGES_MINISTERY_SERVICES_PNG,
    R.ASSETS_IMAGES_WORK_PNG
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: List.generate(
            categories.length,
            (index) => _FacilityCard(
              label: categories[index].name,
              catID: categories[index].id,
              asset: assets[index],
            ),
          ),
        ),
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  final String label;
  final catID;
  final String asset;

  _FacilityCard({Key key, this.label, this.asset, this.catID})
      : super(key: key);
  final labelStyle = TxtStyle()
    ..textColor(ColorsD.main)
    ..fontSize(20);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardStyle = ParentStyle()
      ..border(all: 1, color: ColorsD.main)
      ..borderRadius(all: 16)
      ..width(size.width * 0.8)
      ..margin(bottom: 12)
      ..height(size.height / 7)
      ..alignmentContent.center();
    final gesture = Gestures()
      ..onTap(() {
        ExtendedNavigator.rootNavigator.pushNamed(
          Routes.linksPage,
          arguments: LinksPageArguments(title: label),
        );
        RM.get<OccassionsStore>().state.currentCatID = '$catID';
      });
    // TODO: implement build
    return Parent(
      style: cardStyle,
      gesture: gesture,
      child: Container(
        width: size.width * 0.7,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Txt(label, style: labelStyle),
            SizedBox(width: size.width * 0.1),
            Image.asset(asset)
          ],
        ),
      ),
    );
  }
}
