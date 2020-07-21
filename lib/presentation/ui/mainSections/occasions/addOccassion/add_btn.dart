import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AddBtn extends StatelessWidget {
  RMKey<OccassionsStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      observe: () => RM.get<OccassionsStore>(),
      rmKey: _rmKey,
      onIdle: () => _OnData(rmKey: _rmKey),
      onWaiting: () => WaitingWidget(),
      onError: (e) => _OnData(rmKey: _rmKey),
      onData: (d) => _OnData(rmKey: _rmKey),
    );
  }
}

class _OnData extends StatelessWidget {
  final RMKey<OccassionsStore> rmKey;

  _OnData({Key key, this.rmKey}) : super(key: key);
  static double get height => RM.mediaQuery.size.height;
  static double get width => RM.mediaQuery.size.width;
  final style = TxtStyle()
    ..background.color(Colors.amber)
    ..alignmentContent.center()
    ..borderRadius(all: 16)
    ..fontSize(22)
    ..textColor(Colors.white)
    ..margin(all: 25)
    ..height(height / 15)
    ..width(width * 0.5);
  addOccassion() {
    rmKey.setState((s) => s.addOccassion());
    print(rmKey.state.occassion.toJson());
    print('ADDING OCCASSION');
  }

  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()..onTap(addOccassion);
    return StreamBuilder<Object>(
      builder: (context, snapshot) {
        return Txt(
          'إضافة',
          style: style,
          gesture: gesture,
        );
      },
    );
  }
}
