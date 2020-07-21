import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  bool isCreate;

  BuildAuthAppBar({Key key, this.height, this.isCreate = true, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    isCreate =
        isCreate ?? RM.get<AuthStore>().state.authMode == AuthMode.register;
    final style = TxtStyle()
      ..textColor(Colors.white)
      ..fontSize(26)
      ..alignmentContent.center();
    return Container(
      height: preferredSize.height + -24,
      width: preferredSize.width + 10,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(R.ASSETS_IMAGES_PATH_1_PNG),
        ),
      ),
      child:
          Txt("${title!=null?title: isCreate ? 'تسجيل جديد' : "تسجيل الدخول"}", style: style),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
