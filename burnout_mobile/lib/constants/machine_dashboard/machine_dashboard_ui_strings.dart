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

  static const machineDashboardUtilityEditProgramButton = 'Edit Program';

  // Machine Dashboard Utility Setting
  static const machineDashboardUtilitySettingTubeHeater = 'Tube Heater';
  static const machineDashboardUtilitySettingHoldLastStep = 'Hold last step';
  static const machineDashboardUtilitySettingFloorHeater = 'Floor Heater';
  static const machineDashboardUtilitySettingOnCaption =
      'On when temperature reach';
  static const machineDashboardUtilitySettingAfterBurner = 'After Burner';
  static const machineDashboardUtilitySettingOffCaption =
      'Off when temperature reach';
  static const machineDashboardUtilitySettingTurnOffDelayCaption =
      'Turn off delay';
  static const machineDashboardUtilitySettingOverHeatAlarm = 'Overheat Alarm';
  static const machineDashboardUtilitySettingOvenTempLimitCaption =
      'Oven temperature limit at';
  static const machineDashboardUtilitySettingOvenAfterBurnerTempLimitCaption =
      'After burner temperature limit at';
  static const machineDashboardUtilitySettingAirFlowSetting = 'After Burner';
  static const machineDashboardUtilitySettingAdditionalSetting =
      'Additional Settings';
  static const machineDashboardUtilitySettingScheduleOperation =
      'Schedule operation';
  static const machineDashboardUtilitySettingStartAt = 'start at';

  //Machine Dashboard Edit Program Dialog
  static const machineDashboardEditProgramDialogLabelText = 'Program name...';
  static const machineDashboardEditProgramDialogStepMenu = 'Step';
  static const machineDashboardEditProgramDialogSettingMenu = 'Setting';
  static const machineDashboardEditProgramDialogTemperature = 'Temperature';
  static const machineDashboardEditProgramDialogDuration = 'Duration';
  static const machineDashboardEditProgramDialogHr = 'hr';
  static const machineDashboardEditProgramDialogSaveTitle = 'Save';
  static const machineDashboardEditProgramDialogNextTitle = 'Next';
  static String startAtTitle(int step) {
    step = step + 1;
    return 'Start operation at step ${step.toString()}';
  }

  static String contentDialog(int step) {
    step = step + 1;
    return 'Are you sure you want to start at step ${step.toString()}?';
  }

  static const machineDashboardEditProgramDialogSubmitStartAtStep =
      "Yes, I'm sure";

  static const machineDashboardEditProgramDialogNo = 'No';
  static String machineDashboardEditProgramDialogReorderStep(int step) {
    return 'Step ${step + 1}';
  }

  // Machine Dashboard Delete Program Dialog
  static String machineDashboardDeleteProgramDialogTitle(int index){
    index += 1;
    return  'Delete Program $index';
    
  }

  static String machineDashboardDeleteProgramDialoContent(){
    return 'Are you sure you want to delete this program? \nOnce the program get deleted, it cannot be restore.';

  }

  static const machineDashboardDeleteProgramDialoSubmitTitle = "Yes, I'm sure";
  static const machineDashboardDeleteProgramDialoCancelTitle = 'No';
}
