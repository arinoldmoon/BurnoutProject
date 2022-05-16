import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';

class MockMachinePayload {
  final String machineName;
  final MachineStatus machineStatus;
  final String? machineProgram;
  final int? machineProgramSteps;
  final int? machineTimeRemaing;
  final double? machineOnProgramPercent;

  const MockMachinePayload(
      {required this.machineName,
      required this.machineStatus,
      this.machineProgram,
      this.machineProgramSteps,
      this.machineOnProgramPercent,
      this.machineTimeRemaing});

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

  static MockMachinePayload mockMachinePayloadOnProgram =
      const MockMachinePayload(
    machineName: 'machine3',
    machineStatus: MachineStatus.ONPROGRAM,
    machineProgram: 'Operating Program1',
    machineOnProgramPercent: 0.65,
    machineTimeRemaing: 225,
  );
}
