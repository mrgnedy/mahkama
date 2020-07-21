import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/mainSections/category_item.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class HomeCategoriesPage extends StatefulWidget {
  @override
  _HomeCategoriesPageState createState() => _HomeCategoriesPageState();
}

class _HomeCategoriesPageState extends State<HomeCategoriesPage> with AutomaticKeepAliveClientMixin {
//  class HomeCategoriesPage extends StatelessWidget{
  OccassionsStore get occassionsStore => RM.get<OccassionsStore>().state;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Center(
        child: WhenRebuilder<OccassionsStore>(
          initState: (ctx, rm) => rm.setState((s) => s.getHomeCategories()),
          onIdle: () => _BuildCategories(),
          onWaiting: () => occassionsStore.homeCategories == null
              ? WaitingWidget()
              : _BuildCategories(),
          onError: (e) => occassionsStore.homeCategories == null
              ? Txt('فشلت العملية')
              : _BuildCategories(),
          onData: (d) => _BuildCategories(),
          observe: () => RM.get<OccassionsStore>(),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _BuildCategories extends StatelessWidget {
  List<Map<String, String>> mainCategories = [
    {
      'category': "خارطة المحكمة",
      "asset": R.ASSETS_IMAGES_COURT_MAP_PNG,
      "route": Routes.courtSections
    },
    {
      'category': "همة حتى القمة",
      "asset": R.ASSETS_IMAGES_WILL_PNG,
      "route": Routes.allEndeavourPage
    },
    {
      'category': "تسهيل",
      "asset": R.ASSETS_IMAGES_FACILITY_PNG,
      "route": Routes.facilitiesPage
    },
    {
      'category': "مناسبات أسرة العمالية",
      "asset": R.ASSETS_IMAGES_OCCASIONS_PNG,
      "route": Routes.occasionsTypesPage
    },
    {
      'category': "محفظة التطوير الإثرائي",
      "asset": R.ASSETS_IMAGES_WALLET_PNG,
      "route": Routes.devWallet
    },
  ];
  OccassionsStore get occassionState => RM.get<OccassionsStore>().state;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children:
            List.generate(occassionState.homeCategories.data.length, (index) {
          final category = occassionState?.homeCategories?.data[index];
          return Container(
            child: CategoryItem(
              isExpanded: index == 2,
              image: mainCategories[index]['asset'],
              label: category == null
                  ? mainCategories[index]['category']
                  : category.name,
              catID: category?.id ?? index + 1,
              // routeArgs: mainCategories[index]['routeArgs'],
              routeName: mainCategories[index]['route'],
            ),
          );
        }),
      ),
    );
  }
}
