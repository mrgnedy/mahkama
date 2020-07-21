import 'package:flutter/material.dart';
import 'package:mahkama/core/api_utils.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'occasionCard.dart';

class OccassionPage extends StatelessWidget {
  final SubCategory occassion;

  const OccassionPage({Key key, this.occassion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          height: size.height / 8,
          title: '${occassion.name}',
        ),
        body: _BuildBody(occassion: occassion),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  final SubCategory occassion;

  const _BuildBody({Key key, this.occassion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: size.width * 0.8,
          child: Column(
            children: <Widget>[
              _BuildImage(image: occassion.image),
              SizedBox(height: size.height * 0.03),
              BuildOccasionDetail(
                  label: '${occassion.nameOwner}',
                  icon: Icons.person,
                  isExpanded: true),
              BuildOccasionDetail(
                  label: '${occassion.address}',
                  icon: Icons.pin_drop,
                  isExpanded: true),
              BuildOccasionDetail(
                  label: '${occassion.date}',
                  icon: Icons.date_range,
                  isExpanded: true),
              BuildOccasionDetail(
                  label: '${occassion.time}',
                  icon: Icons.access_time,
                  isExpanded: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildImage extends StatelessWidget {
  final String image;

  const _BuildImage({Key key, this.image}) : super(key: key);
  // double get width => RM.mediaQuery.size.width;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 4,
      width: width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber),
          color: ColorsD.main,
          image: DecorationImage(
            image: NetworkImage('${APIs.imageBaseUrl}$image'),
          )),
    );
  }
}

class _DetailsFitBox extends StatelessWidget {
  final Widget child;

  const _DetailsFitBox({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.height * 0.7,
      alignment: Alignment.centerRight,
      child: FittedBox(
        alignment: Alignment(-1, 0),
        child: child,
      ),
    );
  }
}
