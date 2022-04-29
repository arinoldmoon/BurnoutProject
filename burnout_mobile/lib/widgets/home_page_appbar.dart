import 'package:burnout_mobile/constants/custom_color.dart';
import 'package:burnout_mobile/constants/home_page_sizes.dart';
import 'package:burnout_mobile/constants/home_page_ui_strings.dart';
import 'package:burnout_mobile/data_models/home_page_tabbar_menu.dart';
import 'package:flutter/material.dart';

class HomePageAppbar extends StatefulWidget {
  const HomePageAppbar({Key? key}) : super(key: key);

  @override
  State<HomePageAppbar> createState() => _HomePageAppbarState();
}

class _HomePageAppbarState extends State<HomePageAppbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: HomePageSizes.homePageMenuLenght,
      child: Column(
        children: [
          TabBar(
              isScrollable: true,
              labelColor: CustomColor.yellowPrimary,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.transparent,
              labelPadding: HomePageSizes.homePageMenuSpacing,
              padding: EdgeInsets.zero,
              labelStyle: Theme.of(context).textTheme.subtitle2,
              tabs: HomePageTabbarMenu.homePageMenu),
        ],
      ),
    );
  }
}
