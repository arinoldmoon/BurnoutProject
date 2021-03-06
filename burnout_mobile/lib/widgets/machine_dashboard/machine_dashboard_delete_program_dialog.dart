import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_dialog.dart';
import 'package:flutter/material.dart';

class MachineDashboardDeleteProgramDialog extends StatelessWidget {
  const MachineDashboardDeleteProgramDialog(
      {Key? key,
      required this.programIndex,
      required this.cancelCallBack,
      required this.submitCallBack})
      : super(key: key);

  final int programIndex;
  final VoidCallback cancelCallBack;
  final VoidCallback submitCallBack;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      titleText:
          MachineDashboardUiStrings.machineDashboardDeleteProgramDialogTitle(
              programIndex),
      contentText: RichText(
        key: const Key('contentText'),
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            const TextSpan(
              text: MachineDashboardUiStrings
                  .machineDashboardDeleteProgramDialoContent,
            ),
            TextSpan(
              text: MachineDashboardUiStrings
                  .machineDashboardCancelOperationContentCannotBeRestore,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppTheme.redPrimary100),
            ),
          ],
        ),
      ),
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
