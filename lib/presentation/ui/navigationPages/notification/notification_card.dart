import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/api_utils.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/notification_model.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class NotificationCard extends StatelessWidget {
  final int index;

   NotificationCard({Key key, this.index}) : super(key: key);
  NotificationDetail get notificationDetail => RM
      .get<AuthStore>()
      .state
      .notificationModel
      .data[index];
  final parentStyle = ParentStyle()
    ..width(RM.mediaQuery.size.width * 0.8)
    ..height(RM.mediaQuery.size.height / 8)
    ..border(all: 1, color: ColorsD.main)
    ..borderRadius(all: 12)
    ..margin(bottom:5);
   
  @override
  Widget build(BuildContext context) {
    
    return Parent(
        style: parentStyle,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: <Widget>[
                  Expanded(child: Txt('${notificationDetail.body}', style: TxtStyle()..textAlign.right(),)),
                  _BuildImage(
                    image: notificationDetail.occasion?.image,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(-0.91,0.91),
              child: Txt('${notificationDetail.createdAt}'),
            )
          ],
        ));
  }
}

class _BuildImage extends StatelessWidget {
  final String image;
  num get height => RM.mediaQuery.size.height / 8;
  num get width => RM.mediaQuery.size.width * 0.24;
  const _BuildImage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
      child: image.toString().contains('null')
          ? Image.asset(R.ASSETS_IMAGES_LOCATION_BIG_PNG,
              height: height, width: width)
          : Image.network(
              "${APIs.imageBaseUrl}$image",
              cacheHeight: height.toInt(),
              cacheWidth: width.toInt(),
              height: height.toDouble(),
              width: width.toDouble(),
            ),
    );
  }
}
