import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occasionCard.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:mahkama/const/resource.dart';

class BuildTabBarView extends StatelessWidget {
  final controller;
  final bool hasFinishedData =
      RM.get<OccassionsStore>().state.finishedOccasions != null;
  final bool hasInitData =
      RM.get<OccassionsStore>().state.initialOccasions != null;

  BuildTabBarView({Key key, this.controller}) : super(key: key);
  List<SubCategory> get initialOccs =>
      RM.get<OccassionsStore>().state.initialOccasions.data;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TabBarView(controller: controller, children: [
      WhenRebuilder<OccassionsStore>(
        initState: (_, rm) => rm.setState((s) => s.getFinishedOccasions()),
        observe: () => RM.get<OccassionsStore>(),
        onIdle: () => FinishedOccassions(),
        onWaiting: () =>
            hasFinishedData ? FinishedOccassions() : WaitingWidget(),
        onError: (e) => hasFinishedData
            ? FinishedOccassions()
            : Center(child: Txt('تعذرت العملية')),
        onData: (d) => FinishedOccassions(),
      ),
      WhenRebuilder<OccassionsStore>(
        initState: (_, rm) => rm.setState((s) => s.getInitialOccasions()),
        observe: () => RM.get<OccassionsStore>(),
        onIdle: () => CurrentOccassions(),
        onWaiting: () => hasInitData ? CurrentOccassions() : WaitingWidget(),
        onError: (e) => hasInitData
            ? CurrentOccassions()
            : Center(child: Txt('تعذرت العملية')),
        onData: (d) => CurrentOccassions(),
      ),
    ]));
  }
}

class FinishedOccassions extends StatelessWidget {
  List<SubCategory> get occassions =>
      RM.get<OccassionsStore>().state.finishedOccasions.data;
  @override
  Widget build(BuildContext context) {
    return occassions == null || occassions.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(R.ASSETS_IMAGES_FINISHED_PNG),
                Txt('لا توجد مناسبات منتهية')
              ],
            ),
          )
        : ListView.builder(
      shrinkWrap: true,
      itemCount: occassions.length,
      itemBuilder: (context, index) => Align(
        child: OccasionCard(
          occassion: occassions[index],
        ),
      ),
    );
  }
}

class CurrentOccassions extends StatelessWidget {
  List<SubCategory> get occassions =>
      RM.get<OccassionsStore>().state.initialOccasions?.data;
  @override
  Widget build(BuildContext context) {
    return occassions == null || occassions.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(R.ASSETS_IMAGES_FINISHED_PNG),
                Txt('لا توجد مناسبات حالية')
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: occassions.length,
            itemBuilder: (context, index) => Align(
              child: OccasionCard(
                occassion: occassions[index],
              ),
            ),
          );
  }
}
