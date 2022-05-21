import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:flutter/widgets.dart';

class MachineDashboardPeripheralZoneProvider with ChangeNotifier {
  List<MachinePeripheral> machinePeripheralZone = [
    MachinePeripheral(
        machinePeripheralType: MachinePeripheralType.AIRFLOW,
        machineOnOffStatus: MachineOnOffStatus.ON),
    MachinePeripheral(
        machinePeripheralType: MachinePeripheralType.DOOR,
        machineOnOffStatus: MachineOnOffStatus.OFF),
  ];

  List<MachinePeripheral> getMachinePeripheralZone() {
    return machinePeripheralZone;
  }

  void addMachinePeripheralZone(MachinePeripheral data) {
    machinePeripheralZone.add(data);
  }
}
