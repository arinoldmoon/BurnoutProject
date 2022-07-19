import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:flutter/widgets.dart';

class MachineDashboardUtilityStepProvider extends ChangeNotifier {
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
