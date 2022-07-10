import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_dialog.dart';
import 'package:flutter/material.dart';

class MachineDashboardDeleteProgramDialog extends StatelessWidget {
  MachineDashboardDeleteProgramDialog(
      {Key? key,
      required this.programIndex,
      required this.cancelCallBack,
      required this.submitCallBack})
      : super(key: key);

  final int programIndex;
  VoidCallback cancelCallBack;
  VoidCallback submitCallBack;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      titleText:
          MachineDashboardUiStrings.machineDashboardDeleteProgramDialogTitle(
              programIndex),
      contentText:
          MachineDashboardUiStrings.machineDashboardDeleteProgramDialoContent(),
      submitButtonTile: MachineDashboardUiStrings
          .machineDashboardDeleteProgramDialoSubmitTitle,
      cancelButtonTile: MachineDashboardUiStrings
          .machineDashboardDeleteProgramDialoCancelTitle,
      submitButtonColor: AppTheme.redPrimary100,
      cancelButtonColor: AppTheme.greyPrimary400,
      cancelButtonCallBack: cancelCallBack,
      submitButtonCallBack: submitCallBack,
    );
  }
}
