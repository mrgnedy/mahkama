import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/ui/drawerPages/drawer.dart';
import 'package:mahkama/presentation/ui/navigationPages/main_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  openDrawer() => _scaffoldKey.currentState.openEndDrawer();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: DrawerPage(),
        appBar: _BuildAppBar(height: size.height / 10, callback: openDrawer),
        body: Stack(
          children: <Widget>[
            MainPage(),
            Align(
                alignment: Alignment.bottomCenter,
                child: _BottomNavigationBar())
          ],
        ),
      ),
    );
  }
}

class _BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Function callback;

  _BuildAppBar({Key key, this.height, this.callback, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(width: size.width / 8),
        _TitleRebuilder(),
        GestureDetector(
          onTap: callback,
          child: Container(
            alignment: Alignment.centerLeft,
            width: size.width / 8,
            child: Image.asset(R.ASSETS_IMAGES_MENU_PNG),
          ),
        )
      ],
    );
  }

  // @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _TitleRebuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr(
      observe: () => RM.get<PageState>(),
      builder: (context, model) => _TitleOnData(),
    );
  }
}

class _TitleOnData extends StatelessWidget {
  final currentPage = RM.get<PageState>().state.currentPage;
  final titles = ["الصفحة الشخصية", "الرئيسية", "الإشعارات"];
  final txtSyle = TxtStyle()
    ..fontWeight(FontWeight.bold)
    ..textColor(ColorsD.main)
    ..fontSize(24);
  String get title => titles[currentPage];
  
  @override
  Widget build(BuildContext context) {
    return Txt('$title', style: txtSyle);
  }
}

class _BottomNavigationBar extends StatefulWidget {
  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  navigateToPage(int page) {
    RM.get<PageState>().setState((s) => s.currentPage=page);
    RM.get<PageState>().state.pageCtrler.animateToPage(page,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 8,
      color: Colors.transparent,
      child: CustomPaint(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.4),
              child: Container(
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () => navigateToPage(1),
                  child: Image.asset(R.ASSETS_IMAGES_HOME_PNG),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.645, 0.25),
              child: Container(
                alignment: Alignment.center,
                width: 25,
                height: 25,
                child: InkWell(
                  onTap: () => navigateToPage(0),
                  child: Image.asset(R.ASSETS_IMAGES_USER_PNG),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.645, 0.25),
              child: Container(
                width: 25,
                height: 25,
                child: InkWell(
                  onTap: () => navigateToPage(2),
                  child: Image.asset(R.ASSETS_IMAGES_NOTIFICATION_PNG),
                ),
              ),
            ),
          ],
        ),
        foregroundPainter: CustomNavigationBar(
          height: size.height / 4,
          width: size.width,
        ),
      ),
    );
  }
}

class CustomNavigationBar extends CustomPainter {
  final double height;
  final double width;

  CustomNavigationBar({this.height, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(width / 2, height / 2, width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, 0);
    final centerCirclePath = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(width / 2, height / 5), radius: 30));
    final leftCirclePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(width * 0.2, height / 3.3), radius: 25));
    final rightCirclePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(width * 0.8, height / 3.3), radius: 25));

    final compinedPath =
        Path.combine(PathOperation.difference, path, centerCirclePath);
    final compinedPath1 =
        Path.combine(PathOperation.difference, compinedPath, leftCirclePath);
    final compinedPath2 =
        Path.combine(PathOperation.difference, compinedPath1, rightCirclePath);
    // TODO: implement paint
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawShadow(compinedPath2, Colors.black, 18, false);
    canvas.drawPath(compinedPath2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
