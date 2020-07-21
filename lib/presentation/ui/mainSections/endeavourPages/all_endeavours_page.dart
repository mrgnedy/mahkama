import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class AllEndeavourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          height: size.height / 8,
          image: R.ASSETS_IMAGES_BACK_PNG,
          title: "همة حتى القمة",
          callback: () => ExtendedNavigator.rootNavigator.pop(),
        ),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  RMKey<OccassionsStore> _rmKey = RMKey<OccassionsStore>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      heightFactor: 2,
      child: Container(
        width: size.width * 0.75,
        child: WhenRebuilder<OccassionsStore>(
          initState: (_, __) => _rmKey.setState((s) => s.getCategoryByID()),
          rmKey: _rmKey,
          observe: () => RM.get<OccassionsStore>(),
          onIdle: () => Container(),
          onWaiting: () => _rmKey.state.currentCategories == null
              ? WaitingWidget()
              : _OnData(),
          onError: (e) => _rmKey.state.currentCategories == null
              ? Txt('فشلت العملية')
              : _OnData(),
          onData: (d) => _OnData(),
        ),
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  OccassionsStore get occassionsState => RM.get<OccassionsStore>().state;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
      // padding: EdgeInsets.all(51),
      separatorBuilder: (context, int) => SizedBox(height: 10),
      shrinkWrap: true,
      itemCount: occassionsState.currentCategories.data.length,
      itemBuilder: (_, index) {
        final category =
            occassionsState.currentCategories.data[index] as SubCatTypeTwo;
        return AchievementCard(
          title: '${category.name}',
          body: '${category.text}',
        );
      },
    );
  }
}

class AchievementCard extends StatelessWidget {
  final String title;
  final String body;
  AchievementCard({Key key, this.title, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parentStyle = ParentStyle()
      ..width(size.width * 0.75)
      ..borderRadius(all: 16)
      ..border(all: 1, color: ColorsD.main)
      ..padding(all: 8);
    final bodyStyle = TxtStyle()
      ..textColor(Colors.black)
      ..textAlign.right()
      ..width(size.width * 0.75)
      ..maxWidth(size.width * 0.75)
      ..maxLines(2)
      ..textOverflow(TextOverflow.ellipsis);
    final titleStyle = TxtStyle()
      ..textColor(ColorsD.main)
      ..width(size.width * 0.75)
      ..fontSize(20)
      ..textAlign.right();

    final gesture = Gestures()
      ..onTap(
        () => ExtendedNavigator.rootNavigator.pushNamed(
          Routes.endeavourPage,
          arguments: EndeavourPageArguments(
            endeavour: title,
            body: body,
          ),
        ),
      );
    return Parent(
      style: parentStyle,
      gesture: gesture,
      child: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Txt(title, style: titleStyle),
            Txt(body, style: bodyStyle),
          ],
        ),
      ),
    );
  }
}
