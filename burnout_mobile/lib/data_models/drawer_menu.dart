import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class DrawerMenuModel {
  final Icon icon;
  final String title;

  DrawerMenuModel({required this.icon, required this.title});

  static List<DrawerMenuModel> drawerMenuList = [
    DrawerMenuModel(
      icon: const Icon(
        PhosphorIcons.hard_drives,
        size: Sizes.drawerMenuSlideIconSize,
        color: Colors.white,
      ),
      title: UiStrings.drawerMenuMyMachine,
    ),
    DrawerMenuModel(
      icon: const Icon(
        PhosphorIcons.gear_six,
        size: Sizes.drawerMenuSlideIconSize,
        color: Colors.white,
      ),
      title: UiStrings.drawerMenuSetting,
    ),
    DrawerMenuModel(
      icon: const Icon(
        PhosphorIcons.phone_disconnect,
        size: Sizes.drawerMenuSlideIconSize,
        color: Colors.white,
      ),
      title: UiStrings.drawerMenuContact,
    )
  ];
}
