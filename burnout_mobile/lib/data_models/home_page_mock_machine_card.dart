import 'package:burnout_mobile/constants/homepage/home_page_constants.dart';
import 'package:burnout_mobile/constants/routes.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:flutter/material.dart';

class HomePageMockMachineCard {
  final bool machineStatus;
  final String machineName;
  final String machinePic;
  final String machineModel;
  final VoidCallback onTap;

  HomePageMockMachineCard(
      {required this.machineStatus,
      required this.machineName,
      required this.machinePic,
      required this.machineModel,
      required this.onTap});

  static List<HomePageMockMachineCard> homePageMockMachineCardList(
      BuildContext context) {
    return [
      HomePageMockMachineCard(
        machineStatus: true,
        machineName: 'machineName1',
        machineModel: 'machineModel1',
        machinePic: HomePageConstants.homePageMachineCardMachinePic,
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.machineDashboardPage,
            arguments: {
              RouteParameters.machinePayload:
                  MockMachinePayload.mockMachinePayloadIdle
            },
          );
        },
      ),
      HomePageMockMachineCard(
          machineStatus: true,
          machineName: 'machineName2',
          machineModel: 'machineModel2',
          machinePic: HomePageConstants.homePageMachineCardMachinePic,
          onTap: () {}),
      HomePageMockMachineCard(
          machineStatus: false,
          machineName: 'machineName3',
          machineModel: 'machineModel3',
          machinePic: HomePageConstants.homePageMachineCardMachinePic,
          onTap: () {}),
    ];
  }
}
