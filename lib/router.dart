import 'package:auto_route/auto_route_annotations.dart';
import 'package:mahkama/presentation/ui/authPages/auth_page.dart';
import 'package:mahkama/presentation/ui/authPages/forget_password.dart';
import 'package:mahkama/presentation/ui/authPages/rechange_pw.dart';
import 'package:mahkama/presentation/ui/authPages/select_auth.dart';
import 'package:mahkama/presentation/ui/authPages/verify_page.dart';
import 'package:mahkama/presentation/ui/drawerPages/about_page.dart';
import 'package:mahkama/presentation/ui/drawerPages/contactUs.dart/contact_us.dart';
import 'package:mahkama/presentation/ui/drawerPages/my_occassions.dart/my_occassions.dart';
import 'package:mahkama/presentation/ui/mainSections/courtMap/court_category_pag.dart';
import 'package:mahkama/presentation/ui/mainSections/courtMap/court_sections.dart';
import 'package:mahkama/presentation/ui/mainSections/development_wallet/dev_wallet.dart';
import 'package:mahkama/presentation/ui/mainSections/endeavourPages/all_endeavours_page.dart';
import 'package:mahkama/presentation/ui/mainSections/endeavourPages/endeavour_page.dart';
import 'package:mahkama/presentation/ui/mainSections/facilityPages/facilities_page.dart';
import 'package:mahkama/presentation/ui/mainSections/links_page.dart';
import 'package:mahkama/presentation/ui/mainSections/home_page.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/addOccassion/add_occasions.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occasions_categories_page.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occassion_page.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/occassionsPage/occasion_page.dart';
import 'package:mahkama/presentation/ui/onBoarding/onBoardingPage.dart';
import 'package:mahkama/presentation/ui/page_selection.dart';
import 'package:mahkama/presentation/widgets/map.dart';

@MaterialAutoRouter()
class $Router {
  SelectAuthPage selectAuthPage;
  AuthPage authPage;
  VerifyPage verifyPage;
  @initial
  PageSelection pageSelection;
  OnBoardingPage onBoardingPage;
  HomePage mainPage;
  AllEndeavourPage allEndeavourPage;
  EndeavourPage endeavourPage;
  CourtCategoryPage courtCategoryPage;
  CourtSections courtSections;
  FacilitiesPage facilitiesPage;
  LinksPage linksPage;
  DevWallet devWallet;
  OccasionsTypesPage occasionsTypesPage;
  OcasionsPage occasionsPage;
  AddOccasion addOccasion;
  MapScreen mapScreen;
  MyOccassionsPage myOccassionsPage;
  OccassionPage occassionPage;
  RechangePage rechangePage;
  ForgetPasswordPage forgetPasswordPage;
  ContactUs contactUs;
  AboutPage aboutPage;
  
}
