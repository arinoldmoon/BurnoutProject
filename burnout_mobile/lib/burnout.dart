import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/home_page/home_page_tabbar.dart';
import 'package:flutter/material.dart';

import 'constants/homepage/home_page_sizes.dart';
import 'constants/homepage/home_page_ui_strings.dart';

class Burnout extends StatefulWidget {
  const Burnout({Key? key}) : super(key: key);

  @override
  State<Burnout> createState() => _BurnoutState();
}

class _BurnoutState extends State<Burnout> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryBackGroungColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              HomePageUiStrings.homePageAppBarTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: HomePageSizes.homePageAppBarTitleSpacing),
            Text(
              HomePageUiStrings.homePageAppBarTitleTailing,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            color: Colors.black,
          ),
        ],
      ),
      body: const HomePageTabbar(),
    );
  }
}
