import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/pages/machine_dashboard/machine_dashboard_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.machineDashboardPage: (context) {
      final Map args = ModalRoute.of(context)!.settings.arguments as Map;
      final MockMachinePayload machinePayload =
          args[RouteParameters.machinePayload];
      return MachineDashboardPage(machinePayload: machinePayload);
    },
  };
}

class RouteNames {
  static const machineDashboardPage = 'machineDashBoardPage';
}

class RouteParameters {
  static const machinePayload = "machinePayload";
}
