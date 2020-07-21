import 'dart:math';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';

class BuildButtomSheet extends StatelessWidget {
  final Function callBack;
  final CrossFadeState state;

  const BuildButtomSheet({Key key, this.callBack, this.state})
      : super(key: key);

  // const BuildButtomSheet({Key key, this.callBack}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 15,
      width: size.width,
      child: BottomSheet(
          onClosing: () {},
          builder: (context) {
            return InkWell(
              onTap: callBack,
              child: state.index==0? _Forward() : _Backward(),
            );
          }),
    );
  }
}

class _Forward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Txt('تخطى'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(R.ASSETS_IMAGES_BACK_PNG),
        ),
      ],
    );
  }
}

class _Backward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Transform.rotate(
              angle: pi, child: Image.asset(R.ASSETS_IMAGES_BACK_PNG)),
        ),
        Txt('رجوع'),
      ],
    );
  }
}
