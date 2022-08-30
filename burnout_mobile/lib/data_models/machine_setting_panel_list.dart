import 'package:burnout_mobile/constants/machine_setting/machine_setting_ui_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class MachineSettingPanelList {
  final List<String> expandedValue;
  final String headerValue;
  final String subTitleValue;
  final IconData leadingIcon;
  bool isExpanded;

  MachineSettingPanelList({
    required this.leadingIcon,
    required this.expandedValue,
    required this.headerValue,
    required this.subTitleValue,
    this.isExpanded = false,
  });

  static List<MachineSettingPanelList> machineSettingPanelList = [
    MachineSettingPanelList(
      expandedValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueAboutMachineExpandedValue,
      headerValue:
          MachineSettingUiStrings.machineSettingPanelHeaderValueAboutMachine,
      subTitleValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueAboutMachineSubTitle,
      leadingIcon: PhosphorIcons.info,
    ),
    MachineSettingPanelList(
      expandedValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueNetworkAndConnectionExpandedValue,
      headerValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueNetworkAndConnection,
      subTitleValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueNetworkAndConnectionSubTitle,
      leadingIcon: PhosphorIcons.wifi_high,
    ),
    MachineSettingPanelList(
      expandedValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueOperationSettingExpandedValue,
      headerValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueOperationSetting,
      subTitleValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueOperationSettingSubTitle,
      leadingIcon: PhosphorIcons.gear_six,
    ),
    MachineSettingPanelList(
      expandedValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueSupportAndFaqExpandedValue,
      headerValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueSupportAndFaqSubTitle,
      subTitleValue: MachineSettingUiStrings
          .machineSettingPanelHeaderValueSupportAndFaqSubTitle,
      leadingIcon: PhosphorIcons.question,
    ),
  ];
}
