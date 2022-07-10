import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/data_models/drawer_menu_model.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
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
        child: SlideTransition(
          position: position,
          child: Container(
            padding: Sizes.drawerMenuContainerPadding,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppTheme.blackPrimary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      key: const Key('closeButton'),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.reverse();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        PhosphorIcons.x,
                        size: Sizes.drawerMenuSlideIconSize,
                        color: AppTheme.yellowPrimary,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: Sizes.drawerMenuContainerPadding,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0;
                              i < DrawerMenuModel.drawerMenuList.length;
                              i++)
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentPage = i;
                                    });
                                  },
                                  child: Container(
                                    height: Sizes.drawerMenuSlideMenuHeight,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: (() {
                                        if (currentPage == i) {
                                          return AppTheme.yellowPrimary;
                                        } else {
                                          return AppTheme.blackPrimary;
                                        }
                                      }()),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          DrawerMenuModel
                                              .drawerMenuList[i].icon,
                                          size: Sizes.drawerMenuSlideIconSize,
                                          color: Colors.white,
                                          key: const Key('leadingIcon'),
                                        ),
                                        const SizedBox(
                                          width: Sizes
                                              .drawerMenuSlideIconTitleSpacing,
                                        ),
                                        Text(
                                          DrawerMenuModel
                                              .drawerMenuList[i].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          key:  Key('titleMenuText$i'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: Sizes.drawerMenuSlideMenuSpacing,
                                ),
                              ],
                            )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
