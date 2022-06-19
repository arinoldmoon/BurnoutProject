import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_edit_program_tab.dart';
import 'package:burnout_mobile/widgets/utility/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MachineDashboardEditProgramDialog extends StatefulWidget {
  const MachineDashboardEditProgramDialog({Key? key}) : super(key: key);

  @override
  State<MachineDashboardEditProgramDialog> createState() =>
      _MachineDashboardEditProgramDialogState();
}

class _MachineDashboardEditProgramDialogState
    extends State<MachineDashboardEditProgramDialog> {
  final programNameController = TextEditingController();

  @override
  void dispose() {
    programNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          MachineDashboardSizes.machineDashboardEditProgramDialogInsetPadding,
      child: Container(
        padding: MachineDashboardSizes.machineDashboardEditProgramDialogPadding,
        height: MachineDashboardSizes.machineDashboardEditProgramDialogHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MachineDashboardSizes
              .machineDashboardEditProgramDialogBorderRadius),
          color: AppTheme.primaryBackGroungColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonTextFormField(
                      labelText: MachineDashboardUiStrings
                          .machineDashboardEditProgramDialogLabelText,
                      fillColor: AppTheme.primaryBackGroungColor,
                      borderFocusColorBorder: AppTheme.yellowPrimary,
                      controller: programNameController,
                    ),
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
                          .machineDashboardEditProgramDialogIconButtonSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: MachineDashboardSizes
                    .machineDashboardEditProgramDialogContentSpacing,
              ),
              const MachineDashboardEditProgramTab(),
            ],
          ),
        ),
      ),
    );
  }
}
