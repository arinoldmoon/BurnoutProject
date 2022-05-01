import 'package:burnout_mobile/constants/custom_color.dart';
import 'package:burnout_mobile/constants/home_page_sizes.dart';
import 'package:burnout_mobile/data_models/home_page_tabbar_menu.dart';
import 'package:flutter/material.dart';

class HomePageTabbar extends StatelessWidget {
  const HomePageTabbar({Key? key}) : super(key: key);

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
            labelStyle: Theme.of(context).textTheme.subtitle1,
            tabs: HomePageTabbarMenu.homePageMenu,
          ),
          const SizedBox(height: HomePageSizes.homePageMenuBodySpacing),
          Flexible(
            child: TabBarView(
              children: HomePageTabbarMenu.tabbarView,
            ),
          ),
        ],
      ),
    );
  }
}
