import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:burnout_mobile/services/oven_services.dart';
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';

class MachineDashboardPeripheralZoneProvider with ChangeNotifier {
  List<MachinePeripheral> machinePeripheralZone = [];

  Future<void> fetchMonitorDevice() async {
    ResponseStream<ProtoOvenResponse> response =
        await OvenServices.fetchMonitorDevice();
    response.listen(
      (value) {
        machinePeripheralZone = [
          MachinePeripheral(
            machinePeripheralType: MachinePeripheralType.DOOR,
            machineOnOffStatus: value.status.door
                ? MachineOnOffStatus.ON
                : MachineOnOffStatus.OFF,
          ),
          MachinePeripheral(
            machinePeripheralType: MachinePeripheralType.AIRFLOW,
            machineOnOffStatus: value.coil.coilPump
                ? MachineOnOffStatus.ON
                : MachineOnOffStatus.OFF,
          ),
        ];
      },
    );
    notifyListeners();
  }

  List<MachinePeripheral> get peripheralZone => machinePeripheralZone;

  int get count => machinePeripheralZone.length;

  void addMachinePeripheralZone(MachinePeripheral data) {
    machinePeripheralZone.add(data);
    debugPrint(count.toString());

    notifyListeners();
  }
}
