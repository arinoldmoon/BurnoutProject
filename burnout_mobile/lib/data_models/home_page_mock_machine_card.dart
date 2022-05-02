import 'package:burnout_mobile/constants/home_page_constants.dart';
import 'package:burnout_mobile/constants/home_page_ui_strings.dart';
import 'package:flutter/material.dart';

class HomePageMockMachineCard {
  final bool machineStatus;
  final String machineName;
  final String? machinePic;
  final String machineModel;
  final VoidCallback onTap;

  HomePageMockMachineCard(
      {required this.machineStatus,
      required this.machineName,
      this.machinePic,
      required this.machineModel,
      required this.onTap});

  static List<HomePageMockMachineCard> homePageMockMachineCardList = [
    HomePageMockMachineCard(
        machineStatus: true,
        machineName: 'machineName1',
        machineModel: 'machineModel1',
        onTap: () {}),
    HomePageMockMachineCard(
        machineStatus: true,
        machineName: 'machineName2',
        machineModel: 'machineModel2',
        onTap: () {}),
    HomePageMockMachineCard(
        machineStatus: false,
        machineName: 'machineName3',
        machineModel: 'machineModel3',
        onTap: () {}),
  ];
}
