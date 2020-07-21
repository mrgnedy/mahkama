import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occasionCard.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'my_occassions_tabbar.dart';
import 'my_occassions_tabview.dart';

class MyOccassionsPage extends StatelessWidget {
  double get height => RM.mediaQuery.size.height;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(title: "مناسباتى", height: height / 8),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  @override
  __BuildBodyState createState() => __BuildBodyState();
}

class __BuildBodyState extends State<_BuildBody>
    with SingleTickerProviderStateMixin {
  TabController _tabCtrler;
  @override
  void initState() {
    // TODO: implement initState
    _tabCtrler = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BuildTabBar(controller: _tabCtrler),
        SizedBox(height: RM.mediaQuery.size.height * 0.04),
        BuildTabBarView(controller: _tabCtrler),
      ],
    );
  }
}

