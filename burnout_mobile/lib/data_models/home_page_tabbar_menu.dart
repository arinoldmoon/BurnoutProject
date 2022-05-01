import 'package:burnout_mobile/constants/home_page_ui_strings.dart';
import 'package:burnout_mobile/pages/Homepage/home_page_all.dart';
import 'package:burnout_mobile/pages/Homepage/home_page_burnout.dart';
import 'package:burnout_mobile/pages/Homepage/home_page_casting.dart';
import 'package:burnout_mobile/pages/Homepage/home_page_wax_injection.dart';
import 'package:flutter/material.dart';

class HomePageTabbarMenu {
  static const List<Tab> homePageMenu = [
    Tab(text: HomePageUiStrings.homePageAllTabbarTitle),
    Tab(text: HomePageUiStrings.homePageBurnoutTabbarTitle),
    Tab(text: HomePageUiStrings.homePageCastingTabbarTitle),
    Tab(text: HomePageUiStrings.homePageWaxInjectionTabbarTitle),
  ];

  static List<Widget> tabbarView = [
    const HomePageAll(),
    const HomePageBurnout(),
    const HomePageCasting(),
    const HomePageWaxInjection()
  ];
}
