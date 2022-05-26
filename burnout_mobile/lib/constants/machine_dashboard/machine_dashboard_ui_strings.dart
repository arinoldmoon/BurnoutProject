class MachineDashboardUiStrings {
  // Machine Dasboard Page

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

  // Machine Dashboard Temperature
  static const machineDashboardTemperatureOven = 'Oven';
  static const machineDashboardTemperatureAfb = 'AFB';
  static const machineDashboardTemperatureTube = 'Tube';
  static const machineDashboardTemperatureFloor = 'Floor';
  static const machineDashboardTemperatureCelciusSymbol = '°C';
  static String machineDashboardTemperatureTempDigit(double temp) {
    return temp.toInt().toString();
  }

  // Machine Dashboard Peripheral
  static const machineDashboardPeripheralDoor = 'Door';
  static const machineDashboardPeripheralAirFlow = 'Air Flow';

  // Machine Dashboard Utility
  static const machineDashboardUtilityMenuOnProgramGraph = 'Graph';
  static const machineDashboardUtilityMenuOnProgramStep = 'Step';
  static const machineDashboardUtilityMenuOnProgramSetting = 'Setting';
  static String machineDashboardHourRemaining(double timeRemaining) {
    return '${timeRemaining / 60} hr';
  }
}
