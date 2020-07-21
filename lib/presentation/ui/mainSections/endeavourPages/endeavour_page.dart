import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';

class EndeavourPage extends StatelessWidget {
  final String endeavour;
  final String body;

  const EndeavourPage({Key key, this.endeavour, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final txtStyle = TxtStyle()
      ..width(size.width * 0.75)
      ..textAlign.center()
      ..alignment.topCenter()
      ..alignmentContent.topCenter();
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
            title: endeavour, height: MediaQuery.of(context).size.height / 8),
        body: SingleChildScrollView(
          child: Txt(body, style: txtStyle),
        ),
      ),
    );
  }
}
