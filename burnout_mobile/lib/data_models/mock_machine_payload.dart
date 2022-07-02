import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:flutter/cupertino.dart';

class MockMachinePayload {
  final String machineName;
  final MachineStatusRun machineStatus;
  final String? machineProgram;
  final int? machineProgramSteps;
  final int? machineTimeRemaing;
  final double? machineOnProgramPercent;
  final List<MachineTemperature>? machineTemperature;
  final List<MachinePeripheral>? machinePeripheral;
  final String machineModel;

  const MockMachinePayload({
    required this.machineName,
    required this.machineStatus,
    required this.machineModel,
    this.machineProgram,
    this.machineProgramSteps,
    this.machineOnProgramPercent,
    this.machineTimeRemaing,
    this.machineTemperature,
    this.machinePeripheral,
  });

  static MockMachinePayload mockMachinePayloadIdle = const MockMachinePayload(
    machineName: 'machine1',
    machineModel: 'S6 Eco',
    machineStatus: MachineStatusRun.IDLE,
  );

  static MockMachinePayload mockMachinePayloadWaiting =
      const MockMachinePayload(
    machineName: 'machine2',
    machineModel: 'S6 Eco',
    machineStatus: MachineStatusRun.WAITING,
    machineProgram: 'Program1',
    machineProgramSteps: 8,
  );

  static MockMachinePayload mockMachinePayloadOnProgram = MockMachinePayload(
    machineName: 'machine3',
    machineModel: 'S6 Eco',
    machineStatus: MachineStatusRun.ONPROGRAM,
    machineProgram: 'Operating Program1',
    machineOnProgramPercent: 0.65,
    machineTimeRemaing: 225,
    machineTemperature: MachineTemperature.mockMachineTemp,
    machinePeripheral: MachinePeripheral.mockMachinePeripheral,
  );
}

class MachineTemperature {
  final double? machineTemp;
  final MachineOnOffStatus? machineHeaterStatus;
  final MachineHeater? machineTempName;

  MachineTemperature({
    this.machineTemp,
    this.machineHeaterStatus,
    this.machineTempName,
  });

  static List<MachineTemperature> mockMachineTemp = [
    MachineTemperature(
      machineTemp: 105,
      machineHeaterStatus: MachineOnOffStatus.ON,
      machineTempName: MachineHeater.OVEN,
    ),
    MachineTemperature(
      machineTemp: 110,
      machineHeaterStatus: MachineOnOffStatus.OFF,
      machineTempName: MachineHeater.AFB,
    ),
    MachineTemperature(
      machineTemp: 125,
      machineHeaterStatus: MachineOnOffStatus.ON,
      machineTempName: MachineHeater.TUBE,
    ),
    MachineTemperature(
      machineTemp: 95,
      machineHeaterStatus: MachineOnOffStatus.OFF,
      machineTempName: MachineHeater.FLOOR,
    )
  ];
}

class MachinePeripheral {
  final MachinePeripheralType machinePeripheralType;
  final MachineOnOffStatus machineOnOffStatus;

  MachinePeripheral(
      {required this.machinePeripheralType, required this.machineOnOffStatus});

  static List<MachinePeripheral> mockMachinePeripheral = [
    MachinePeripheral(
        machinePeripheralType: MachinePeripheralType.AIRFLOW,
        machineOnOffStatus: MachineOnOffStatus.ON),
    MachinePeripheral(
        machinePeripheralType: MachinePeripheralType.DOOR,
        machineOnOffStatus: MachineOnOffStatus.OFF),
  ];
}

class MachineUtilityStep {
  final String machineUtilityStepTitle;
  final double machineUtilityStepTemp;
  final double machineUtilityStepTimeRemaining;
  final MachineUtilityStepStatus machineUtilityStepStatus;
  final MachineUtilityStepProcess machineUtilityStepProcess;

  MachineUtilityStep(
      {required this.machineUtilityStepTitle,
      required this.machineUtilityStepTemp,
      required this.machineUtilityStepTimeRemaining,
      required this.machineUtilityStepStatus,
      required this.machineUtilityStepProcess});
}

class MachineUtilitySetting {
  final double machineUtilitySettingTubeOnTempReach;
  final double machineUtilitySettingFloorOnTempReach;
  final double machineUtilitySettingAfterBurnerOnTempReach;
  final double machineUtilitySettingAfterBurnerOffTempReach;
  final double machineUtilitySettingAfterBurnerTurnOffDelay;
  final double machineUtilitySettingOverHeatAlarmOvenTempLimit;
  final double machineUtilitySettingOverHeatAlarmAfterBurnerTempLimit;
  final double machineUtilitySettingAirFlowOnTempReach;
  final double machineUtilitySettingAirFlowOffTempReach;
  final double machineUtilitySettingAirFlowTurnOffDelay;
  late bool machineUtilitySettingAdditionalHoldLastStep;
  late bool machineUtilitySettingAdditionalScheduleOperationStatus;
  final String machineUtilitySettingAdditionalScheduleOperationDate;

  MachineUtilitySetting({
    required this.machineUtilitySettingTubeOnTempReach,
    required this.machineUtilitySettingFloorOnTempReach,
    required this.machineUtilitySettingAfterBurnerOnTempReach,
    required this.machineUtilitySettingAfterBurnerOffTempReach,
    required this.machineUtilitySettingAfterBurnerTurnOffDelay,
    required this.machineUtilitySettingOverHeatAlarmOvenTempLimit,
    required this.machineUtilitySettingOverHeatAlarmAfterBurnerTempLimit,
    required this.machineUtilitySettingAirFlowOnTempReach,
    required this.machineUtilitySettingAirFlowOffTempReach,
    required this.machineUtilitySettingAirFlowTurnOffDelay,
    required this.machineUtilitySettingAdditionalHoldLastStep,
    required this.machineUtilitySettingAdditionalScheduleOperationStatus,
    required this.machineUtilitySettingAdditionalScheduleOperationDate,
  });
}
