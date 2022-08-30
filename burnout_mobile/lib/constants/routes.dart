import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/pages/machine_dashboard/machine_dashboard_page.dart';
import 'package:burnout_mobile/pages/machine_setting/machine_setting_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.machineDashboardPage: (context) {
      final Map args = ModalRoute.of(context)!.settings.arguments as Map;
      final MockMachinePayload machinePayload =
          args[RouteParameters.machinePayload];
      return MachineDashboardPage(machinePayload: machinePayload);
    },
    RouteNames.machineSettingPage: (context) {
      return const MachineSettingPage();
    },
  };
}

class RouteNames {
  static const machineDashboardPage = 'machineDashBoardPage';
  static const machineSettingPage = 'machineSettingPage';
}

class RouteParameters {
  static const machinePayload = "machinePayload";
}
