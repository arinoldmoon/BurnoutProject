import 'package:burnout_mobile/widgets/home_page_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

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
      ),
      body: const HomePageTabbar(),
    );
  }
}