import 'package:burnout_mobile/constants/home_page_sizes.dart';
import 'package:burnout_mobile/data_models/home_page_mock_machine_card.dart';
import 'package:burnout_mobile/pages/home_page.dart';
import 'package:burnout_mobile/widgets/home_page_machine_card.dart';
import 'package:flutter/material.dart';

class HomePageAll extends StatefulWidget {
  const HomePageAll({Key? key}) : super(key: key);

  @override
  State<HomePageAll> createState() => _HomePageAllState();
}

class _HomePageAllState extends State<HomePageAll> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: HomePageSizes.homePageAllPaddingPage,
      child: GridView.count(
          crossAxisCount: HomePageSizes.homePageAllGridViewSize,
          crossAxisSpacing: HomePageSizes.homePageAllGridViewAxisSpacing,
          mainAxisSpacing: HomePageSizes.homePageAllGridViewAxisSpacing,
          children: HomePageMockMachineCard.homePageMockMachineCardList
              .map((e) => HomePageMachineCard(homePageMockMachineCard: e))
              .toList()),
    );
  }
}
