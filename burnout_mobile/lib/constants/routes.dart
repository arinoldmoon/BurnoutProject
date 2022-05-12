import 'dart:js';

import 'package:burnout_mobile/data_models/machine_payload.dart';
import 'package:burnout_mobile/pages/machine_dashboard_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.machineDashboard: (context) {
      final Map args = ModalRoute.of(context)!.settings.arguments as Map;
      final MachinePayload machinePayload =
          args[RouteParameters.machinePayload];
      return MachineDashboardPage(machinePayload: machinePayload);
    },
  };
}

class RouteNames {
  static const machineDashboard = 'machineDashBoard';
}

class RouteParameters {
  static const machinePayload = "machinePayload";
}
