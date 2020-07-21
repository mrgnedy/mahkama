import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occasionCard.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occassionsPage/filter_bar.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'filter_fab.dart';

class OcasionsPage extends StatelessWidget {
  final String title;

  ScrollController controller = ScrollController();
  OcasionsPage({Key key, this.title}) : super(key: key);
  GlobalKey _fabKey = GlobalKey();
  bool isShown = false;
  controlFabAppearance() {
    controller.position.userScrollDirection == ScrollDirection.reverse
        ? _fabKey.currentState.setState(() => isShown = true)
        : controller.position.extentBefore == 0
            ? _fabKey.currentState.setState(() => isShown = false)
            : null;
  }

  RMKey<OccassionsStore> _rmKey = RMKey();
  bool get hasData => _rmKey.state.currentSubCategories != null;
  @override
  Widget build(BuildContext context) {
    controller.addListener(controlFabAppearance);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: StatefulBuilder(
            key: _fabKey,
            builder: (context, setState) => FAB(isShown: isShown)),
        appBar: BuildAppBar(height: size.height / 8, title: title),
        body: SingleChildScrollView(
          controller: controller,
          child: Center(
            child: Column(
              children: [
                FilterBar(),
                SizedBox(height: size.height * 0.05),
                WhenRebuilder<OccassionsStore>(
                  observe: () => RM.get<OccassionsStore>(),
                  rmKey: _rmKey,
                  onIdle: () => _OnData(),
                  onWaiting: () => hasData ? _OnData() : WaitingWidget(),
                  onError: (e) => hasData
                      ? _OnData()
                      : Expanded(child: Center(child: Txt('فشلت العملية'))),
                  onData: (d) => _OnData(),
                  initState: (_, rm) => rm.setState(
                      (s) => s.getSubCategoryByID(),
                      onError: (context, error) =>
                          print('THIS IS OCCASSION $error')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int secID = RM.get<OccassionsStore>().state.secID;
    List<SubCategory> occassions = (RM
            .get<OccassionsStore>()
            .state
            .currentSubCategories
            .data as List<SubCategory>)
        .where((e) {
      return e.sectionId == secID || secID == null;
    }).toList();
    // if (secID != null) occassions.removeWhere((e) => e.sectionId != secID);
    return occassions.isEmpty
        ? Center(
            child: Txt('لا توجد مناسبات فى هذا القسم'),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              occassions.length,
              (index) => OccasionCard(
                occassion: occassions[index],
              ),
            ),
          );
  }
}

// class _BuildBody extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {

//     return ;
//   }
// }
