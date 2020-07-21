import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const BuildAppBar({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: size.width,
      margin: EdgeInsets.only(top: 32, bottom: 16),
      child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
