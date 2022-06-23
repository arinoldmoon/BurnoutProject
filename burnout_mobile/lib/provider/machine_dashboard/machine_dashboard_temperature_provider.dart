import 'dart:developer';

import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/grpc/oven.pb.dart';
import 'package:burnout_mobile/services/grpc_client.dart';
import 'package:burnout_mobile/services/oven_services.dart';
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';

class MachineDashboardTemperatureProvider extends ChangeNotifier {
  final OvenServices _services = OvenServices();
  late List<MachineTemperature> machineTemperatureList = [];

  Future<void> fetchMonitorDevice() async {
    ResponseStream<ProtoOvenResponse> response =
        await OvenServices.fetchMonitorDevice();

    // ResponseStream<ProtoOvenResponse> response =
    //     await _services.fetchMonitorDevice();

    // response.listen(
    //   (value) {
    //     machineTemperatureList = [
    //       MachineTemperature(
    //         machineTempName: MachineHeater.OVEN,
    //         machineTemp: value.temp.tempOven.toDouble(),
    //         machineHeaterStatus: value.coil.coilOven
    //             ? MachineOnOffStatus.ON
    //             : MachineOnOffStatus.OFF,
    //       ),
    //       MachineTemperature(
    //         machineTempName: MachineHeater.FLOOR,
    //         machineTemp: value.temp.tempFloor.toDouble(),
    //         machineHeaterStatus: value.coil.coilFloor
    //             ? MachineOnOffStatus.ON
    //             : MachineOnOffStatus.OFF,
    //       ),
    //       MachineTemperature(
    //         machineTempName: MachineHeater.AFB,
    //         machineTemp: value.temp.tempAFB.toDouble(),
    //         machineHeaterStatus: value.coil.coilAFB
    //             ? MachineOnOffStatus.ON
    //             : MachineOnOffStatus.OFF,
    //       ),
    //       MachineTemperature(
    //         machineTempName: MachineHeater.TUBE,
    //         machineTemp: value.temp.tempTube.toDouble(),
    //         machineHeaterStatus: value.coil.coilTube
    //             ? MachineOnOffStatus.ON
    //             : MachineOnOffStatus.OFF,
    //       ),
    //     ];
    //   },
    // );
  }
}
