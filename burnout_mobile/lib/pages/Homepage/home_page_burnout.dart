import 'package:flutter/material.dart';


class HomePageBurnout extends StatefulWidget {
  const HomePageBurnout({ Key? key }) : super(key: key);

  @override
  State<HomePageBurnout> createState() => _HomePageBurnoutState();
}

class _HomePageBurnoutState extends State<HomePageBurnout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Burnout"),
    );
  }
}