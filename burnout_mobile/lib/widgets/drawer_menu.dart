import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    position = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 56.0),
            child: SlideTransition(
              position: position,
              child: Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.reverse();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
