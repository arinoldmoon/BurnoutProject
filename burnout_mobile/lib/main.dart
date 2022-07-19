import 'package:burnout_mobile/burnout.dart';
import 'package:burnout_mobile/constants/routes.dart';
import 'package:burnout_mobile/grpc/google/protobuf/empty.pb.dart';
import 'package:burnout_mobile/grpc/google/protobuf/wrappers.pb.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:burnout_mobile/pages/home_page.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/test_grpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => MachineDataProvider(),
      )
    ],
    child: MaterialApp(
        theme:
            ThemeData(scaffoldBackgroundColor: AppTheme.primaryBackGroungColor),
        routes: Routes.routes,
        home: const Burnout()),
  ));
}
