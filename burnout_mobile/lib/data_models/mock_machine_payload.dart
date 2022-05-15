import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';

class MockMachinePayload {
  final String machineName;
  final MachineStatus machineStatus;
  final String? machineProgram;
  final int? machineProgramSteps;

  const MockMachinePayload(
      {required this.machineName,
      required this.machineStatus,
      this.machineProgram,
      this.machineProgramSteps});

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
}
