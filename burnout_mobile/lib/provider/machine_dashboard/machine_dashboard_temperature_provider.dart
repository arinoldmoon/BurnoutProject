import 'dart:developer';

import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/grpc/oven.pb.dart';
import 'package:burnout_mobile/services/oven_services.dart';
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';

class MachineDashboardTemperatureProvider extends ChangeNotifier {
  final OvenServices _services = OvenServices();
  late List<MachineTemperature> machineTemperatureList = [];

  void fetchMonitorDevice() async {
    ResponseStream<ProtoOvenResponse> response =
        await _services.fetchMonitorDevice();
    response.listen((value) {
      machineTemperatureList.add(
        MachineTemperature(
          machineTempName: MachineHeater.OVEN,
          machineTemp: value.temp.tempOven.toDouble(),
          machineHeaterStatus: value.coil.coilOven
              ? MachineOnOffStatus.ON
              : MachineOnOffStatus.OFF,
        ),
      );
    });
    print('${machineTemperatureList.length}');
  }
}
