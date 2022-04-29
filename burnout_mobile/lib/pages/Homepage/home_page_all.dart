import 'package:flutter/material.dart';



class HomePageAll extends StatefulWidget {
  const HomePageAll({ Key? key }) : super(key: key);

  @override
  State<HomePageAll> createState() => _HomePageAllState();
}

class _HomePageAllState extends State<HomePageAll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("All"),
    );
  }
}