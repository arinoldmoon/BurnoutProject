import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:flutter/widgets.dart';

class MachineDashboardUtilitySettingProvider extends ChangeNotifier {
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

  void isCheckAdditionalHoldLastStep(bool? value) {
    machineUtilitySetting.machineUtilitySettingAdditionalHoldLastStep = value!;
    notifyListeners();
  }

  void isCheckAdditionalScheduleOperation(bool? value) {
    machineUtilitySetting
        .machineUtilitySettingAdditionalScheduleOperationStatus = value!;
    notifyListeners();
  }
}
