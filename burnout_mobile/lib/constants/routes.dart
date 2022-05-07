import 'dart:js';

import 'package:flutter/material.dart';

class Routes{
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.machineDashboard: (context) => Container(),
  };
}

class RouteNames{
  static const machineDashboard = 'machineDashBoard';
}

class RouteParameters{}
