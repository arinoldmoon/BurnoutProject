import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class DrawerMenuModel {
  final IconData icon;
  final String title;

  DrawerMenuModel({required this.icon, required this.title});

  static List<DrawerMenuModel> drawerMenuList = [
    DrawerMenuModel(
      icon: PhosphorIcons.hard_drives,
      title: UiStrings.drawerMenuMyMachine,
    ),
    DrawerMenuModel(
      icon: PhosphorIcons.gear_six,
      title: UiStrings.drawerMenuSetting,
    ),
    DrawerMenuModel(
      icon: PhosphorIcons.phone_disconnect,
      title: UiStrings.drawerMenuContact,
    )
  ];
}
