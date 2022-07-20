import 'package:flutter/widgets.dart';
import '../constants/machine_dashboard/machine_dashboard_ui_strings.dart';
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

  MockMachinePayload get getMockMachinePayloadOnProgram =>
      mockMachinePayloadOnProgram;

  MockMachinePayload get getMockMachinePayloadWaiting =>
      mockMachinePayloadWaiting;

  MockMachinePayload get getMockMachinePayloadIdle => mockMachinePayloadIdle;

  List<MachinePeripheral> machinePeripheralZoneList = [
    MachinePeripheral(
        machinePeripheralType: MachinePeripheralType.AIRFLOW,
        machineOnOffStatus: MachineOnOffStatus.OFF),
    MachinePeripheral(
        machinePeripheralType: MachinePeripheralType.DOOR,
        machineOnOffStatus: MachineOnOffStatus.OFF),
  ];

  List<MachinePeripheral> get peripheralZone => machinePeripheralZoneList;

  int get countMachinePeripheralZoneList => machinePeripheralZoneList.length;

  void addMachinePeripheralZone(MachinePeripheral data) {
    machinePeripheralZoneList.add(data);
    debugPrint(countMachinePeripheralZoneList.toString());
    notifyListeners();
  }

  MachineUtilitySetting machineUtilitySetting = MachineUtilitySetting(
      machineUtilitySettingTubeOnTempReach: 120,
      machineUtilitySettingFloorOnTempReach: 120,
      machineUtilitySettingAfterBurnerOnTempReach: 120,
      machineUtilitySettingAfterBurnerOffTempReach: 90,
      machineUtilitySettingAfterBurnerTurnOffDelay: 60,
      machineUtilitySettingOverHeatAlarmOvenTempLimit: 120,
      machineUtilitySettingOverHeatAlarmAfterBurnerTempLimit: 120,
      machineUtilitySettingAirFlowOnTempReach: 120,
      machineUtilitySettingAirFlowOffTempReach: 120,
      machineUtilitySettingAirFlowTurnOffDelay: 60,
      machineUtilitySettingAdditionalHoldLastStep: false,
      machineUtilitySettingAdditionalScheduleOperationStatus: true,
      machineUtilitySettingAdditionalScheduleOperationDate: '18:00 01/02/2022');

  MachineUtilitySetting get getMachineUtilitySetting => machineUtilitySetting;

  void isCheckAdditionalHoldLastStep(bool? value) {
    machineUtilitySetting.machineUtilitySettingAdditionalHoldLastStep = value!;
    notifyListeners();
  }

  void isCheckAdditionalScheduleOperation(bool? value) {
    machineUtilitySetting
        .machineUtilitySettingAdditionalScheduleOperationStatus = value!;
    notifyListeners();
  }

  late List<String> stepListStartAt = [];
  List<MachineUtilityStep> machineDashboardUtilityStepList = [
    MachineUtilityStep(
        machineUtilityStepTitle: 'Step 1',
        machineUtilityStepProcess: MachineUtilityStepProcess.COOLING,
        machineUtilityStepStatus: MachineUtilityStepStatus.DONE,
        machineUtilityStepTemp: 90,
        machineUtilityStepTimeRemaining: 120),
    MachineUtilityStep(
        machineUtilityStepTitle: 'Step 2',
        machineUtilityStepProcess: MachineUtilityStepProcess.HEATING,
        machineUtilityStepStatus: MachineUtilityStepStatus.DONE,
        machineUtilityStepTemp: 90,
        machineUtilityStepTimeRemaining: 120),
    MachineUtilityStep(
        machineUtilityStepTitle: 'Step 3',
        machineUtilityStepProcess: MachineUtilityStepProcess.MAINTAIN,
        machineUtilityStepStatus: MachineUtilityStepStatus.WORKINGON,
        machineUtilityStepTemp: 90,
        machineUtilityStepTimeRemaining: 120),
    MachineUtilityStep(
        machineUtilityStepTitle: 'Step 4',
        machineUtilityStepProcess: MachineUtilityStepProcess.HEATING,
        machineUtilityStepStatus: MachineUtilityStepStatus.UPCOMING,
        machineUtilityStepTemp: 90,
        machineUtilityStepTimeRemaining: 120),
    MachineUtilityStep(
        machineUtilityStepTitle: 'Step 5',
        machineUtilityStepProcess: MachineUtilityStepProcess.MAINTAIN,
        machineUtilityStepStatus: MachineUtilityStepStatus.UPCOMING,
        machineUtilityStepTemp: 90,
        machineUtilityStepTimeRemaining: 120),
    MachineUtilityStep(
        machineUtilityStepTitle: 'Step 6',
        machineUtilityStepProcess: MachineUtilityStepProcess.COOLING,
        machineUtilityStepStatus: MachineUtilityStepStatus.UPCOMING,
        machineUtilityStepTemp: 90,
        machineUtilityStepTimeRemaining: 120),
  ];

  int get countMachineDashboardUtilityStepList =>
      machineDashboardUtilityStepList.length;

  void reOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final MachineUtilityStep item =
        machineDashboardUtilityStepList.removeAt(oldIndex);

    item.machineUtilityStepTitle =
        MachineDashboardUiStrings.machineDashboardEditProgramDialogReorderStep(
            newIndex);
    machineDashboardUtilityStepList.insert(newIndex, item);
    for (int i = 0; i < newIndex; i++) {
      machineDashboardUtilityStepList[i].machineUtilityStepTitle =
          MachineDashboardUiStrings
              .machineDashboardEditProgramDialogReorderStep(i);
    }
    for (int j = newIndex; j < machineDashboardUtilityStepList.length; j++) {
      machineDashboardUtilityStepList[j].machineUtilityStepTitle =
          MachineDashboardUiStrings
              .machineDashboardEditProgramDialogReorderStep(j);
    }

    notifyListeners();
  }

  void startAtStep(int step) {
    stepListStartAt.clear();
    for (int i = 0; i < step; i++) {
      stepListStartAt
          .add(machineDashboardUtilityStepList[i].machineUtilityStepTitle);
    }
    notifyListeners();
  }

  void addMoreStep(MachineUtilityStep machineUtilityStep) {
    machineDashboardUtilityStepList.add(machineUtilityStep);
    notifyListeners();
  }

  List<MachineUtilityStep> get machineUtiltilityStepList =>
      machineDashboardUtilityStepList;

  List<String> get getStepListStartAt => stepListStartAt;
}
