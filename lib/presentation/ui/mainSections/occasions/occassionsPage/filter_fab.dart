import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahkama/core/utils.dart';

import 'filter_bar.dart';

class FAB extends StatefulWidget {
  final bool isShown;

  const FAB({Key key, this.isShown}) : super(key: key);

  @override
  __FABState createState() => __FABState();
}

class __FABState extends State<FAB> {
  bool isExtended = false;
  onFabTab() {
    setState(() {
      isExtended = true;
    });
  }

  Widget fabLabel() => isExtended ? FilterBar() : Icon(FontAwesomeIcons.filter);

  @override
  Widget build(BuildContext context) {
    return widget.isShown
        ? FloatingActionButton.extended(
            backgroundColor: ColorsD.main,
            isExtended: isExtended,
            label: fabLabel(),
            onPressed: onFabTab)
        : Container();
  }
}
