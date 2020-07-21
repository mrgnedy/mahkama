import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/api_utils.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class OccasionCard extends StatelessWidget {
  final SubCategory occassion;

  const OccasionCard({Key key, this.occassion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parentStyle = ParentStyle()
      ..borderRadius(all: 16)
      ..border(all: 1, color: ColorsD.main)
      ..width(size.width * 0.7)
      ..height(size.height / 6.5)
      ..margin(bottom: 12);
    final imageStyle = ParentStyle()
      ..borderRadius(topRight: 16, bottomRight: 16)
      ..height(size.height / 8);
    final gesture = Gestures()
      ..onTap(() {
        ExtendedNavigator.rootNavigator.pushNamed(Routes.occassionPage,
            arguments: OccassionPageArguments(occassion: occassion));
      });
    return Parent(
      style: parentStyle,
      gesture: gesture,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BuildOccasionDetail(
                    label: '${occassion.nameOwner}', icon: Icons.person),
                BuildOccasionDetail(
                    label: '${occassion.address}', icon: Icons.pin_drop),
                BuildOccasionDetail(
                    label: '${occassion.date}', icon: Icons.date_range),
                BuildOccasionDetail(
                    label: '${occassion.time}', icon: Icons.access_time),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
              child: Image.network(
                '${APIs.imageBaseUrl}${occassion.image}',
                loadingBuilder: (context, child, chunk) => StylesD.loadImage(
                    size.height / 6.5, size.width * 0.23, chunk, child),
                fit: BoxFit.cover,
                cacheHeight: size.height ~/ 6.5,
                height: size.height / 6.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildOccasionDetail extends StatelessWidget {
  final bool isExpanded;
  final String label;
  final IconData icon;

  BuildOccasionDetail({Key key, this.label, this.icon, this.isExpanded = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final style = TxtStyle()
      ..fontSize(isExpanded ? 16 : 12)
      ..maxLines(isExpanded ? 5 : 1)
      ..textOverflow(TextOverflow.ellipsis)
      ..width(MediaQuery.of(context).size.width * (isExpanded ? 0.5 : 0.3))
      ..textAlign.right()
      ..textColor(Colors.black);
    return Padding(
      padding: EdgeInsets.only(bottom: isExpanded ? 8.0 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Txt(label, style: style),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, right: 5, left: 5),
            child: Icon(icon, color: ColorsD.main, size: isExpanded ? 25 : 15),
          )
        ],
      ),
    );
  }
}
