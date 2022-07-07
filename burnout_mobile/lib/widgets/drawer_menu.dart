import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

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

    controller = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: Sizes.drawerMenuSlideAnimationDuration));
    position = Tween<Offset>(
            begin: Sizes.drawerMenuSlideAnimationBeginOffSet, end: Offset.zero)
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
          child: SlideTransition(
            position: position,
            child: Container(
              padding: Sizes.drawerMenuContainerPadding,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.blackPrimary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        controller.reverse();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        PhosphorIcons.x,
                        size: 32.0,
                        color: AppTheme.yellowPrimary,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          width: 125,
                          color: AppTheme.yellowPrimary,
                          child: const ListTile(
                            title: Text("Menu 1"),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 125,
                          color: AppTheme.yellowPrimary,
                          child: const ListTile(
                            title: Text("Menu 1"),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 125,
                          color: AppTheme.yellowPrimary,
                          child: const ListTile(
                            title: Text("Menu 1"),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 125,
                          color: AppTheme.yellowPrimary,
                          child: const ListTile(
                            title: Text("Menu 1"),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 125,
                          color: AppTheme.yellowPrimary,
                          child: const ListTile(
                            title: Text("Menu 1"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
