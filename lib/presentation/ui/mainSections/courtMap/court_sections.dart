import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/mainSections/category_item.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';
import '../category_item.dart';

class CourtSections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          height: size.height / 8,
          title: "خارطة المحكمة",
        ),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  OccassionsStore get occassionState => RM.get<OccassionsStore>().state;
  RMKey<OccassionsStore> osKey = RMKey<OccassionsStore>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      // width: size.width*0.8,
      child: WhenRebuilder<OccassionsStore>(
        rmKey: osKey,
        initState: (context,rm ) => osKey.setState((s) => s.getCategoryByID()),
        observe: ()=>RM.get<OccassionsStore>(),
        onIdle: ()=>Container(),
        onWaiting: ()=> occassionState.currentCategories == null? WaitingWidget(): _OnData(),
        onError: (e)=> occassionState.currentCategories == null? Txt('فشلت العملية') : _OnData(),
        onData: (d)=>_OnData(),
      ),
    );
  }
}
class _OnData extends StatelessWidget {
  final List<Map<String, dynamic>> dummySections = [
    {
      "section": "مكتب رئيس المحكمة",
      "asset": R.ASSETS_IMAGES_COURT_DIRECTOR_PNG
    },
    {
      "section": "إدارة الموارد البشرية",
      "asset": R.ASSETS_IMAGES_RESOURCES_PNG
    },
    {"section": "الدوائر القضائية", "asset": R.ASSETS_IMAGES_COURT_CIRCLES_PNG},
    {"section": "إدارة الدعاوى والأحكام", "asset": R.ASSETS_IMAGES_LAWSUIT_PNG},
    {"section": "خدمات الجمهور", "asset": R.ASSETS_IMAGES_CROWD_PNG},
    {"section": "القسم النسائي", "asset": R.ASSETS_IMAGES_FEMINE_PNG},
  ];
  @override
  Widget build(BuildContext context) {
    final sections = RM.get<OccassionsStore>().state.currentCategories.data as List<Category>;
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: List.generate(sections.length, (index) {
          return CategoryItem(
          image: dummySections[index]['asset'],
          isExpanded: false,
          label: sections[index].name,
          catID: sections[index].id,
          routeName: Routes.courtCategoryPage,
          routeArgs: CourtCategoryPageArguments(title: sections[index].name) ,
        );
        })
      );
  }
}