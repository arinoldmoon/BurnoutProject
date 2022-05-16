class MachineDashboardUiStrings {
  // Machine Dashboard Status
  static const machineDashboardStatus = "Status :";
  static const machineDashboardIdle = "Idle";
  static const machineDashboardWaiting = "Waiting";
  static const machineDashboardOnProgram = "Operating Program 1";
  static const machineDashboardLoadProgram = "Load Program";
  static const machineDashboardNewProgram = "New Program";
  static const machineDashboardProgramName = "Program Name :";
  static const machineDashboardNumberOfSteps = "Number of Step :";
  static String machineDashboardStatusHourRemaining(int timeRemaining) {
    return '${timeRemaining / 60} hr ${timeRemaining % 60} min remaing';
  }
}
