import 'package:flutter/widgets.dart';
import '../constants/machine_dashboard/machine_enum.dart';
import '../data_models/mock_machine_payload.dart';

class MachineDataProvider with ChangeNotifier {
  MockMachinePayload mockMachinePayloadIdle = const MockMachinePayload(
    machineName: 'machine1',
    machineModel: 'S6 Eco',
    machineStatus: MachineStatusRun.IDLE,
    machineModelYear: '',
    machineSerialNumber: '',
    machineSoftwareVersion: '',
    machineWarranty: '',
  );

  MockMachinePayload mockMachinePayloadWaiting = const MockMachinePayload(
    machineName: 'machine2',
    machineModel: 'S6 Eco',
    machineStatus: MachineStatusRun.WAITING,
    machineProgram: 'Program1',
    machineProgramSteps: 8,
    machineModelYear: '',
    machineSerialNumber: '',
    machineSoftwareVersion: '',
    machineWarranty: '',
  );

  MockMachinePayload mockMachinePayloadOnProgram = MockMachinePayload(
    machineName: 'machine3',
    machineModel: 'S6 Eco',
    machineStatus: MachineStatusRun.ONPROGRAM,
    machineProgram: 'Operating Program1',
    machineOnProgramPercent: 0.65,
    machineTimeRemaing: 225,
    machineTemperature: MachineTemperature.mockMachineTemp,
    machinePeripheral: MachinePeripheral.mockMachinePeripheral,
    machineModelYear: '',
    machineSerialNumber: '',
    machineSoftwareVersion: '',
    machineWarranty: '',
  );
}
