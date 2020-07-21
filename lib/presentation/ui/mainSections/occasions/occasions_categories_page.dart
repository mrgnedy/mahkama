import 'package:auto_route/auto_route.dart';
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

class OccasionsTypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Directionality(
          textDirection: TextDirection.rtl,
          child: FloatingActionButton(
              onPressed: ()=>ExtendedNavigator.rootNavigator.pushNamed(Routes.addOccasion),
              backgroundColor: ColorsD.main,
              child: Icon(Icons.add, size: 35)),
        ),
        appBar: BuildAppBar(
            height: size.height / 8, title: "مناسبات الأسرة العمالية"),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  
  RMKey<OccassionsStore> _rmKey = RMKey();
  bool get hasData => RM.get<OccassionsStore>().state.currentCategories !=null;
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder<OccassionsStore>(
      onIdle: ()=>_OnData(),
      onWaiting:()=>hasData? _OnData(): WaitingWidget(),
      onError: (e)=>hasData? _OnData(): Center(child:Txt('فشلت العملية')),
      onData: (d)=>_OnData(),
      observe: () => RM.get<OccassionsStore>(),
      rmKey: _rmKey,
      initState: (_,__)=>_rmKey.setState((s) => s.getCategoryByID(),onError:(context, error) => print(error), ),
    );
  }
}
class _OnData extends StatelessWidget {
  List<Category> get occassionTypes => RM.get<OccassionsStore>().state.currentCategories.data;
  final List<Map<String, String>> occasionTypeList = [
    {
      "name": 'مبروك الدرجة العلمية',
      "asset": R.ASSETS_IMAGES_DEGREE_PNG,
      "catID": ''
    },
    {
      "name": 'مبروك الترقية',
      "asset": R.ASSETS_IMAGES_PROMOTION_PNG,
      "catID": ''
    },
    {"name": 'يتربى في عزك', "asset": R.ASSETS_IMAGES_BABY_PNG, "catID": ''},
    {
      "name": 'القفص الذهبى',
      "asset": R.ASSETS_IMAGES_GOLDEN_ZONE_PNG,
      "catID": ''
    },
    {"name": 'حج مبرور', "asset": R.ASSETS_IMAGES_HAJ_PNG, "catID": ''},
    {
      "name": 'الى رحمة الله تعالى',
      "asset": R.ASSETS_IMAGES_HOSPITALITY_PNG,
      "catID": ''
    },
    {"name": 'أجر وعافية', "asset": R.ASSETS_IMAGES_RESOURCES_PNG, "catID": ''}
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: List.generate(
              occassionTypes.length,
              (index) {
                final occasionType = occasionTypeList[index];
                return CategoryItem(
                  catID: occassionTypes[index].id,
                  label: occasionType['name'],
                  routeName: Routes.occasionsPage,
                  routeArgs: OcasionsPageArguments(title: occasionType['name']),
                  image: occasionType['asset'],
                  isExpanded: index == occassionTypes.length - 1,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}