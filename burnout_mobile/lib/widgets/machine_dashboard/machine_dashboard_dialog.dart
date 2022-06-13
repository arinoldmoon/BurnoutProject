import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_edit_program_tab.dart';
import 'package:burnout_mobile/widgets/utility/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MachineDashboardDialog extends StatelessWidget {
  const MachineDashboardDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: MachineDashboardSizes.machineDashboardDialogPadding,
        width: MachineDashboardSizes.machineDashboardDialogWidth,
        height: MachineDashboardSizes.machineDashboardDialogHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              MachineDashboardSizes.machineDashboardDialogBorderRadius),
          color: AppTheme.primaryBackGroungColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: CommonTextFormField(
                      labelText: MachineDashboardUiStrings
                          .machineDashboardTextFormFieldEditProgramLabelText),
                ),
                IconButton(
                  color: AppTheme.yellowPrimary,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    PhosphorIcons.xCircle,
                    size: MachineDashboardSizes
                        .machineDashboardDialogIconButtonSize,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height:
                  MachineDashboardSizes.machineDashboardDialogContentSpacing,
            ),
            const MachineDashboardEditProgramTab(),
          ],
        ),
      ),
    );
  }
}
