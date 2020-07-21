// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mahkama/presentation/ui/authPages/select_auth.dart';
import 'package:mahkama/presentation/ui/authPages/auth_page.dart';
import 'package:mahkama/presentation/ui/authPages/verify_page.dart';
import 'package:mahkama/presentation/ui/page_selection.dart';
import 'package:mahkama/presentation/ui/onBoarding/onBoardingPage.dart';
import 'package:mahkama/presentation/ui/mainSections/home_page.dart';
import 'package:mahkama/presentation/ui/mainSections/endeavourPages/all_endeavours_page.dart';
import 'package:mahkama/presentation/ui/mainSections/endeavourPages/endeavour_page.dart';
import 'package:mahkama/presentation/ui/mainSections/courtMap/court_category_pag.dart';
import 'package:mahkama/presentation/ui/mainSections/courtMap/court_sections.dart';
import 'package:mahkama/presentation/ui/mainSections/facilityPages/facilities_page.dart';
import 'package:mahkama/presentation/ui/mainSections/links_page.dart';
import 'package:mahkama/presentation/ui/mainSections/development_wallet/dev_wallet.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occasions_categories_page.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occassionsPage/occasion_page.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/addOccassion/add_occasions.dart';
import 'package:mahkama/presentation/widgets/map.dart';
import 'package:mahkama/presentation/ui/drawerPages/my_occassions.dart/my_occassions.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occassion_page.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/presentation/ui/authPages/rechange_pw.dart';
import 'package:mahkama/presentation/ui/authPages/forget_password.dart';
import 'package:mahkama/presentation/ui/drawerPages/contactUs.dart/contact_us.dart';
import 'package:mahkama/presentation/ui/drawerPages/about_page.dart';

abstract class Routes {
  static const selectAuthPage = '/select-auth-page';
  static const authPage = '/auth-page';
  static const verifyPage = '/verify-page';
  static const pageSelection = '/';
  static const onBoardingPage = '/on-boarding-page';
  static const mainPage = '/main-page';
  static const allEndeavourPage = '/all-endeavour-page';
  static const endeavourPage = '/endeavour-page';
  static const courtCategoryPage = '/court-category-page';
  static const courtSections = '/court-sections';
  static const facilitiesPage = '/facilities-page';
  static const linksPage = '/links-page';
  static const devWallet = '/dev-wallet';
  static const occasionsTypesPage = '/occasions-types-page';
  static const occasionsPage = '/occasions-page';
  static const addOccasion = '/add-occasion';
  static const mapScreen = '/map-screen';
  static const myOccassionsPage = '/my-occassions-page';
  static const occassionPage = '/occassion-page';
  static const rechangePage = '/rechange-page';
  static const forgetPasswordPage = '/forget-password-page';
  static const contactUs = '/contact-us';
  static const aboutPage = '/about-page';
  static const all = {
    selectAuthPage,
    authPage,
    verifyPage,
    pageSelection,
    onBoardingPage,
    mainPage,
    allEndeavourPage,
    endeavourPage,
    courtCategoryPage,
    courtSections,
    facilitiesPage,
    linksPage,
    devWallet,
    occasionsTypesPage,
    occasionsPage,
    addOccasion,
    mapScreen,
    myOccassionsPage,
    occassionPage,
    rechangePage,
    forgetPasswordPage,
    contactUs,
    aboutPage,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.selectAuthPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SelectAuthPage(),
          settings: settings,
        );
      case Routes.authPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AuthPage(),
          settings: settings,
        );
      case Routes.verifyPage:
        if (hasInvalidArgs<VerifyPageArguments>(args)) {
          return misTypedArgsRoute<VerifyPageArguments>(args);
        }
        final typedArgs = args as VerifyPageArguments ?? VerifyPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              VerifyPage(key: typedArgs.key, isForget: typedArgs.isForget),
          settings: settings,
        );
      case Routes.pageSelection:
        return MaterialPageRoute<dynamic>(
          builder: (context) => PageSelection(),
          settings: settings,
        );
      case Routes.onBoardingPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => OnBoardingPage(),
          settings: settings,
        );
      case Routes.mainPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(),
          settings: settings,
        );
      case Routes.allEndeavourPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AllEndeavourPage(),
          settings: settings,
        );
      case Routes.endeavourPage:
        if (hasInvalidArgs<EndeavourPageArguments>(args)) {
          return misTypedArgsRoute<EndeavourPageArguments>(args);
        }
        final typedArgs =
            args as EndeavourPageArguments ?? EndeavourPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => EndeavourPage(
              key: typedArgs.key,
              endeavour: typedArgs.endeavour,
              body: typedArgs.body),
          settings: settings,
        );
      case Routes.courtCategoryPage:
        if (hasInvalidArgs<CourtCategoryPageArguments>(args)) {
          return misTypedArgsRoute<CourtCategoryPageArguments>(args);
        }
        final typedArgs =
            args as CourtCategoryPageArguments ?? CourtCategoryPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CourtCategoryPage(
              key: typedArgs.key,
              title: typedArgs.title,
              specs: typedArgs.specs,
              mail: typedArgs.mail,
              whatsApp: typedArgs.whatsApp),
          settings: settings,
        );
      case Routes.courtSections:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CourtSections(),
          settings: settings,
        );
      case Routes.facilitiesPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => FacilitiesPage(),
          settings: settings,
        );
      case Routes.linksPage:
        if (hasInvalidArgs<LinksPageArguments>(args)) {
          return misTypedArgsRoute<LinksPageArguments>(args);
        }
        final typedArgs = args as LinksPageArguments ?? LinksPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              LinksPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Routes.devWallet:
        if (hasInvalidArgs<DevWalletArguments>(args)) {
          return misTypedArgsRoute<DevWalletArguments>(args);
        }
        final typedArgs = args as DevWalletArguments ?? DevWalletArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              DevWallet(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Routes.occasionsTypesPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => OccasionsTypesPage(),
          settings: settings,
        );
      case Routes.occasionsPage:
        if (hasInvalidArgs<OcasionsPageArguments>(args)) {
          return misTypedArgsRoute<OcasionsPageArguments>(args);
        }
        final typedArgs =
            args as OcasionsPageArguments ?? OcasionsPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              OcasionsPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
        );
      case Routes.addOccasion:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddOccasion(),
          settings: settings,
        );
      case Routes.mapScreen:
        if (hasInvalidArgs<MapScreenArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<MapScreenArguments>(args);
        }
        final typedArgs = args as MapScreenArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => MapScreen(),
          settings: settings,
        );
      case Routes.myOccassionsPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MyOccassionsPage(),
          settings: settings,
        );
      case Routes.occassionPage:
        if (hasInvalidArgs<OccassionPageArguments>(args)) {
          return misTypedArgsRoute<OccassionPageArguments>(args);
        }
        final typedArgs =
            args as OccassionPageArguments ?? OccassionPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              OccassionPage(key: typedArgs.key, occassion: typedArgs.occassion),
          settings: settings,
        );
      case Routes.rechangePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RechangePage(),
          settings: settings,
        );
      case Routes.forgetPasswordPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ForgetPasswordPage(),
          settings: settings,
        );
      case Routes.contactUs:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ContactUs(),
          settings: settings,
        );
      case Routes.aboutPage:
        if (hasInvalidArgs<AboutPageArguments>(args)) {
          return misTypedArgsRoute<AboutPageArguments>(args);
        }
        final typedArgs = args as AboutPageArguments ?? AboutPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AboutPage(
              key: typedArgs.key,
              title: typedArgs.title,
              jsonKey: typedArgs.jsonKey),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//VerifyPage arguments holder class
class VerifyPageArguments {
  final Key key;
  final bool isForget;
  VerifyPageArguments({this.key, this.isForget = false});
}

//EndeavourPage arguments holder class
class EndeavourPageArguments {
  final Key key;
  final String endeavour;
  final String body;
  EndeavourPageArguments({this.key, this.endeavour, this.body});
}

//CourtCategoryPage arguments holder class
class CourtCategoryPageArguments {
  final Key key;
  final String title;
  final String specs;
  final String mail;
  final String whatsApp;
  CourtCategoryPageArguments(
      {this.key,
      this.title = "الكابير",
      this.specs =
          "هذاالنص هو عبارة عن تجربة لحجم النص مكتوب للتعبير عن الانجازات التى حققتها وزارة العدل فى مجال صرف المعاشات و توفير فرص العمل للخيريجن تحت سن الثمانين وكلام فاضي كتير كدة",
      this.mail = "mail@gmail.com",
      this.whatsApp = "+07775000"});
}

//LinksPage arguments holder class
class LinksPageArguments {
  final Key key;
  final String title;
  LinksPageArguments({this.key, this.title});
}

//DevWallet arguments holder class
class DevWalletArguments {
  final Key key;
  final String title;
  DevWalletArguments({this.key, this.title = "محفظة التطوير الإثرائى"});
}

//OcasionsPage arguments holder class
class OcasionsPageArguments {
  final Key key;
  final String title;
  OcasionsPageArguments({this.key, this.title});
}

//MapScreen arguments holder class
class MapScreenArguments {
  final Function setLocation;
  MapScreenArguments({@required this.setLocation});
}

//OccassionPage arguments holder class
class OccassionPageArguments {
  final Key key;
  final SubCategory occassion;
  OccassionPageArguments({this.key, this.occassion});
}

//AboutPage arguments holder class
class AboutPageArguments {
  final Key key;
  final String title;
  final String jsonKey;
  AboutPageArguments({this.key, this.title, this.jsonKey});
}
