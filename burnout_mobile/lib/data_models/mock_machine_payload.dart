import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';

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
  final String machineSerialNumber;
  final String machineModelYear;
  final String machineSoftwareVersion;
  final String machineWarranty;
  late MachineNetworkConnection machineNetworkConnection;

  MockMachinePayload({
    required this.machineName,
    required this.machineStatus,
    required this.machineModel,
    this.machineProgram,
    this.machineProgramSteps,
    this.machineOnProgramPercent,
    this.machineTimeRemaing,
    this.machineTemperature,
    this.machinePeripheral,
    required this.machineSerialNumber,
    required this.machineModelYear,
    required this.machineSoftwareVersion,
    required this.machineWarranty,
    required this.machineNetworkConnection,
  });
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
  String machineUtilityStepTitle;
  double machineUtilityStepTemp;
  double machineUtilityStepTimeRemaining;
  MachineUtilityStepStatus machineUtilityStepStatus;
  MachineUtilityStepProcess machineUtilityStepProcess;

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

class MachineNetworkConnection {
  final MachineWifiConnection machineWifiConnection;
  final String machineNetworkConnectionEthernet;
  final String machineNetworkConnectionGateway;
  final String machineNetworkConnectionDNS;

  MachineNetworkConnection({
    required this.machineWifiConnection,
    required this.machineNetworkConnectionEthernet,
    required this.machineNetworkConnectionGateway,
    required this.machineNetworkConnectionDNS,
  });
}

class MachineWifiConnection {
  final String machineWifiConnectionSSID;
  final String machineWifiConnectionPassword;
  final bool machineWifiConnectionDHCP;
  final bool machineWifiConnectionStatic;
  final String machineWifiConnectionIpAddress;
  final String machineWifiConnectionSubnet;

  MachineWifiConnection({
    required this.machineWifiConnectionSSID,
    required this.machineWifiConnectionPassword,
    required this.machineWifiConnectionDHCP,
    required this.machineWifiConnectionStatic,
    required this.machineWifiConnectionIpAddress,
    required this.machineWifiConnectionSubnet,
  });
}

class MachineSupport {
  final String machineSupportContactSupport;
  final String machineSupportUserManual;
  final String machineSupportFaq;

  MachineSupport({
    required this.machineSupportContactSupport,
    required this.machineSupportFaq,
    required this.machineSupportUserManual,
  });

  static MachineSupport machineSupport = MachineSupport(
      machineSupportContactSupport: 'machineSupportContactSupport',
      machineSupportFaq: 'machineSupportFaq',
      machineSupportUserManual: 'machineSupportUserManual');
}
