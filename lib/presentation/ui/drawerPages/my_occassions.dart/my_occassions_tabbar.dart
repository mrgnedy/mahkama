import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildTabBar extends StatelessWidget {
  final controller;

  const BuildTabBar({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: RM.mediaQuery.size.width * 0.7,
      child: TabBar(
        controller: controller,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.amber,
        labelStyle: TextStyle(fontSize: 22, fontFamily: 'bein'),
        unselectedLabelStyle: TextStyle(fontSize: 22, fontFamily: 'bein'),
        indicator: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        tabs: <Widget>[
          Tab(text: 'منتهية'),
          Tab(text: 'حالية'),
        ],
      ),
    );
  }
}
