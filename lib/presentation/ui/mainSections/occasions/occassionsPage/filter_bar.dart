import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahkama/data/models/category_model.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FilterBar extends StatelessWidget {
  RMKey<OccassionsStore> _rmKey = RMKey<OccassionsStore>();
  final rm = RM.get<OccassionsStore>();
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder<OccassionsStore>(
      initState: (_, __) => _rmKey.state.sections == null
          ? _rmKey.setState((s) => s.getSections(),
              onError: (_, error) => print('THIS IS OCCASSIONS PAGE $error'))
          : _rmKey.resetToHasData(),
      observe: () => rm,
      rmKey: _rmKey,
      onIdle: () => Container(),
      onWaiting: () => Container(),
      onError: (e) => _OnData(),
      onData: (d) => _OnData(),
    );
  }
}

class _OnData extends StatefulWidget {
  @override
  __OnDataState createState() => __OnDataState();
}

class __OnDataState extends State<_OnData> {
  List<Category> subsubsbuCategories =
      RM.get<OccassionsStore>().state.sections.data;
  Category selectedCat;

  @override
  void dispose() {
    // TODO: implement dispose
    RM.get<OccassionsStore>().state.secID = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parentStyle = ParentStyle()
      ..width(size.width * 0.7)
      ..height(size.height / 16)
      ..border(all: 1, color: Colors.amber)
      ..borderRadius(all: 16)
      ..padding(all: 8);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Parent(
        style: parentStyle,
        child: DropdownButton<Category>(
          value: selectedCat,
          icon: Icon(FontAwesomeIcons.filter),
          iconEnabledColor: Colors.amber,
          underline: Container(),
          onChanged: (e) {
            RM.get<OccassionsStore>().setState((s) {
              print(s.secID);
              s.secID = e.id;
            });
            setState(() => selectedCat = e);
          },
          isExpanded: true,
          selectedItemBuilder: (ctx) => subsubsbuCategories
              .map((e) => Txt(
                    e.name,
                    style: TxtStyle()
                      ..alignment.centerRight()
                      ..alignmentContent.centerRight(),
                  ))
              .toList(),
          items: subsubsbuCategories
              .map(
                (cat) => DropdownMenuItem(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[Txt(cat.name), Divider()],
                  ),
                  value: cat,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
