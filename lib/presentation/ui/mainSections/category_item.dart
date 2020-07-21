import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CategoryItem extends StatelessWidget {
  final bool isExpanded;
  final String image;
  final String label;
  final catID;
  final dynamic routeArgs;
  final String routeName;
  CategoryItem(
      {Key key,
      this.image,
      this.label,
      this.isExpanded,
      this.routeName,
      this.routeArgs,
      this.catID})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final parentStyle = ParentStyle()
      ..borderRadius(all: 16)
      ..border(all: 1, color: ColorsD.main)
      ..height(size.height / 4.3)
      ..width(isExpanded ? size.width * 0.85 : size.width / 2.5)
      ..margin(all: 8);
    final txtStyle = TxtStyle()
      ..fontWeight(FontWeight.bold)
      ..textColor(ColorsD.main)
      ..fontSize(16)
      ..alignmentContent.bottomCenter()
      ..textAlign.center()
      ..margin(all: 8, bottom: 0);
    final gesture = Gestures()
      ..onTap(() {
        RM.get<OccassionsStore>().state.currentCatID = '$catID';
        return ExtendedNavigator.rootNavigator
            .pushNamed(routeName, arguments: routeArgs);
      });
    return Container(
      // width: isExpanded ? size.width * 0.75 : size.width / 2.5,
      child: Parent(
        style: parentStyle,
        gesture: gesture,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(image),
            Txt(label, style: txtStyle),
          ],
        ),
      ),
    );
  }
}
