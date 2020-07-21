import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/notification_model.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/navigationPages/notification/notification_card.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

// class NotificationPage extends StatelessWidget {
//   double get height => RM.mediaQuery.size.height;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: BuildAppBar(height: height / 8, title: "الإشعارات"),
//       body: _BuildBody(),
//     ));
//   }
// }

class NotificationPage extends StatelessWidget {
  bool get hasData => RM.get<AuthStore>().state.notificationModel != null;
  // RMKey<AuthStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // RM.get<AuthStore>().setState(
    //     (s) => s.notificationModel == null ? s.getNotification() : null);
    return WhenRebuilder<AuthStore>(
      initState: (_, rm) => rm.setState((s) => s.notificationModel == null ? s.getNotification() : null),
      // rmKey: _rmKey,
      observe: () => RM.get<AuthStore>(),
      onIdle: () => Container(),
      onWaiting: () => hasData ? _OnData() : WaitingWidget(),
      onError: (e) => hasData ? _OnData() : Center(child: Txt('تعذر عرض الاشعارات')),
      onData: (d) => _OnData(),
    );
  }
}

class _OnData extends StatelessWidget {
  List<NotificationDetail> get notifications =>
      RM.get<AuthStore>().state.notificationModel.data;
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return notifications == null || notifications.isEmpty
        ? Center(child: Txt('لا توجد اشعارات'))
        : SingleChildScrollView(
            child: Center(
              child: Column(
                children: List.generate(
                  notifications?.length ?? 0,
                  (index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) => getNotification(index),
                      confirmDismiss: (d) => showDeleteDialoge(context),
                      child: InkWell(
                        onTap: () {
                          RM.get<AuthStore>().state.currentNotifIndex = index;
                          navigateOnTap(notifications[index]);
                        },
                        child: NotificationCard(index: index),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }

  navigateOnTap(NotificationDetail notificationDetail) {
    if (notificationDetail.type == 1) {
      if (notificationDetail.occasion == null) return;
      ExtendedNavigator.rootNavigator.pushNamed(
        Routes.occassionPage,
        arguments:
            OccassionPageArguments(occassion: notificationDetail.occasion),
      );
    } else {
      ExtendedNavigator.rootNavigator.pushNamed(Routes.devWallet);
    }
  }

  getNotification(index) {
    RM.get<AuthStore>().setState(
          (s) => s.delNotification(notifications[index].id),
          onData: (context, model) =>
              RM.get<AuthStore>().setState((s) => s.getNotification()),
        );
  }

  Future<bool> showDeleteDialoge(context) async {
    final flatBtnStyle = TxtStyle()..textColor(ColorsD.main);
    final titleStyle = TxtStyle()
      ..textColor(Colors.white)
      ..textAlign.right()
      ..padding(right: 12);
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titlePadding: EdgeInsets.zero,
        title: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
                color: ColorsD.main,
                child: Txt('مسح الإشعار', style: titleStyle))),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Txt('مسح', style: flatBtnStyle),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Txt('رجوع', style: flatBtnStyle),
          ),
        ],
        content: Container(
          height: MediaQuery.of(context).size.height / 9,
          child: Center(child: Txt("هل تريد مسح الإشعار؟")),
        ),
      ),
    );
  }
}
