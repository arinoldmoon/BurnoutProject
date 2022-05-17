import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';

class MockMachinePayload {
  final String machineName;
  final MachineStatus machineStatus;
  final String? machineProgram;
  final int? machineProgramSteps;
  final int? machineTimeRemaing;
  final double? machineOnProgramPercent;
  final List<MachineTemperature>? machineTemperature;

  const MockMachinePayload({
    required this.machineName,
    required this.machineStatus,
    this.machineProgram,
    this.machineProgramSteps,
    this.machineOnProgramPercent,
    this.machineTimeRemaing,
    this.machineTemperature,
  });

  static MockMachinePayload mockMachinePayloadIdle = const MockMachinePayload(
    machineName: 'machine1',
    machineStatus: MachineStatus.IDLE,
  );

  static MockMachinePayload mockMachinePayloadWaiting =
      const MockMachinePayload(
    machineName: 'machine2',
    machineStatus: MachineStatus.WAITING,
    machineProgram: 'Program1',
    machineProgramSteps: 8,
  );

  static MockMachinePayload mockMachinePayloadOnProgram = MockMachinePayload(
      machineName: 'machine3',
      machineStatus: MachineStatus.ONPROGRAM,
      machineProgram: 'Operating Program1',
      machineOnProgramPercent: 0.65,
      machineTimeRemaing: 225,
      machineTemperature: MachineTemperature.mockMachineTemp);
}

class MachineTemperature {
  final double? machineTemp;
  final MachineHeaterStatus? machineHeaterStatus;
  final MachineHeater? machineTempName;

  MachineTemperature({
    this.machineTemp,
    this.machineHeaterStatus,
    this.machineTempName,
  });

  static List<MachineTemperature> mockMachineTemp = [
    MachineTemperature(
      machineTemp: 105,
      machineHeaterStatus: MachineHeaterStatus.ON,
      machineTempName: MachineHeater.OVEN,
    ),
    MachineTemperature(
      machineTemp: 110,
      machineHeaterStatus: MachineHeaterStatus.OFF,
      machineTempName: MachineHeater.AFB,
    ),
    MachineTemperature(
      machineTemp: 125,
      machineHeaterStatus: MachineHeaterStatus.ON,
      machineTempName: MachineHeater.TUBE,
    ),
    MachineTemperature(
      machineTemp: 95,
      machineHeaterStatus: MachineHeaterStatus.ON,
      machineTempName: MachineHeater.FLOOR,
    )
  ];
}
