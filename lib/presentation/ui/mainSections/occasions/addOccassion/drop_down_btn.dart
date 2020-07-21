import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SelectOccassionType extends StatelessWidget {
  RMKey<OccassionsStore> rmKey = RMKey();

  Widget widget(types) => DropDownBtn(
        itemList: types?.data,
        title: "إسم المناسبة",
        callback: (Category section) {
          RM.get<OccassionsStore>().state.occassion.subCategoryId = section.id;
        },
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WhenRebuilder(
      initState: (_, rm) => rmKey.state.sections == null
          ? rmKey.setState((s) => s.getCategoryByID('4'))
          : rmKey.resetToHasData(),
      rmKey: rmKey,
      observe: () => RM.get<OccassionsStore>(),
      onIdle: () => widget(rmKey.state.occassionTypes),
      onWaiting: () => WaitingWidget(),
      onError: (e) => widget(rmKey.state.occassionTypes),
      onData: (d) => widget(rmKey.state.occassionTypes),
    );
  }
}

class SelectSection extends StatelessWidget {
  RMKey<OccassionsStore> rmKey = RMKey();

  Widget widget(sections) => DropDownBtn(
        itemList: sections?.data ?? [],
        title: "القسم",
        callback: (Category section) {
          RM.get<OccassionsStore>().state.occassion.sectionId = section.id;
        },
      );

  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      initState: (_, rm) => rmKey.setState((s) => s.getSections()),
      rmKey: rmKey,
      observe: () => RM.get<OccassionsStore>(),
      onIdle: () => widget(rmKey.state.sections),
      onWaiting: () => rmKey.state.sections != null
          ? widget(rmKey.state.sections)
          : WaitingWidget(),
      onError: (e) => widget(rmKey.state.sections),
      onData: (d) => widget(rmKey.state.sections),
    );
  }
}

class DropDownBtn extends StatefulWidget {
  final List<Category> itemList;
  final String title;
  final Function callback;

  DropDownBtn({Key key, this.itemList = const [], this.callback, this.title})
      : super(key: key);

  @override
  __DropDownBtnState createState() => __DropDownBtnState();
}

class __DropDownBtnState extends State<DropDownBtn> {
  Category selectedItem;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomBorderedWidget(
      title: widget.title,
      width: size.width * 0.7,
      dropDownBtn: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButton<Category>(
          underline: Container(),
          value: selectedItem,
          items: dropDownItems(),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.amber),
          onChanged: (e) {
            widget.callback(e);
            setState(() {
              selectedItem = e;
            });
          },
          selectedItemBuilder: (context) => widget.itemList
              .map(
                (e) => Txt(
                  e.name,
                  style: TxtStyle()..alignmentContent.centerRight(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Category>> dropDownItems() {
    return widget.itemList.map((e) {
      return DropdownMenuItem<Category>(
          child: Column(
            children: <Widget>[
              Txt(e.name),
              Divider(),
            ],
          ),
          value: e);
    }).toList();
  }
}
