import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';

class MockMachinePayload {
  final String machineName;
  final MachineStatus machineStatus;
  final String? machineProgram;

  const MockMachinePayload(
      {required this.machineName,
      required this.machineStatus,
      this.machineProgram});

  static MockMachinePayload mockMachinePayloadIdle = const MockMachinePayload(
    machineName: 'machine1',
    machineStatus: MachineStatus.IDLE,
  );
}
