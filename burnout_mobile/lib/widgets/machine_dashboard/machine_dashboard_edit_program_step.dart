import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_step_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/utility/form_key.dart';
import 'package:burnout_mobile/utility/validator.dart';
import 'package:burnout_mobile/widgets/utility/common_dialog.dart';
import 'package:burnout_mobile/widgets/utility/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MachineDashboardEditProgramStep extends StatefulWidget {
  const MachineDashboardEditProgramStep({
    Key? key,
    this.trailingCallback,
  }) : super(key: key);

  final VoidCallback? trailingCallback;

  @override
  State<MachineDashboardEditProgramStep> createState() =>
      _MachineDashboardEditProgramStepState();
}

class _MachineDashboardEditProgramStepState
    extends State<MachineDashboardEditProgramStep> {
  final List<TextEditingController> _tempTextController = [];
  final List<TextEditingController> _durationTextController = [];
  void callSkipDialog() {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MachineDashboardUtilityStepProvider(),
      child: Consumer<MachineDashboardUtilityStepProvider>(
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Form(
                  key: FormKey.formStepTempAndDurEditStep,
                  child: ReorderableListView.builder(
                    key: const Key('editStepListView'),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    onReorder: (int oldIndex, int newIndex) {
                      value.reOrder(oldIndex, newIndex);
                    },
                    itemBuilder: (_, index) {
                      _tempTextController.add(TextEditingController());
                      _durationTextController.add(TextEditingController());
                      return Column(
                        key: Key('tile$index'),
                        children: [
                          _buildListTileEditStep(
                            context,
                            value.machineDashboardUtilityStepList[index],
                            _tempTextController[index],
                            _durationTextController[index],
                            index,
                          ),
                          const Divider(
                            key: Key('dividerListTile'),
                            indent: MachineDashboardSizes
                                .machineDashboardPeripheralItemSpacing,
                            color: AppTheme.greyPrimary100,
                          )
                        ],
                      );
                    },
                    itemCount: context
                        .watch<MachineDashboardUtilityStepProvider>()
                        .count,
                  ),
                ),
              ),
              const SizedBox(
                height: MachineDashboardSizes
                    .machineDashboardEditStepListViewButtonSpacing,
              ),
              IconButton(
                key: const Key('addMoreStepButton'),
                onPressed: () {
                  value.addMoreStep(
                    MachineUtilityStep(
                        machineUtilityStepTitle:
                            'Step ${value.machineDashboardUtilityStepList.length + 1}',
                        machineUtilityStepTemp: 80,
                        machineUtilityStepTimeRemaining: 80,
                        machineUtilityStepStatus:
                            MachineUtilityStepStatus.UPCOMING,
                        machineUtilityStepProcess:
                            MachineUtilityStepProcess.HEATING),
                  );
                },
                icon: const Icon(
                  PhosphorIcons.plusCircle,
                  size:
                      MachineDashboardSizes.machineDashboardEditStepButtonSize,
                  color: AppTheme.yellowPrimary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTileEditStep(
    BuildContext context,
    MachineUtilityStep machineUtilityStep,
    TextEditingController tempTextFieldController,
    TextEditingController durationTextFieldController,
    int index,
  ) {
    return Container(
      key: Key('$index'),
      alignment: Alignment.center,
      height: MachineDashboardSizes.machineDashboardEditStepTileHeight,
      child: ListTile(
        key: Key(machineUtilityStep.machineUtilityStepTitle),
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap:
            MachineDashboardSizes.machineDashboardEditStepHorizontalGap,
        minLeadingWidth:
            MachineDashboardSizes.machineDashboardEditStepMinWidthLeading,
        onLongPress: callSkipDialog,
        leading: ReorderableDragStartListener(
          index: index,
          child: IconButton(
            key: Key('${machineUtilityStep.machineUtilityStepTitle}leading'),
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.more_vert,
              size: MachineDashboardSizes
                  .machineDashboardEditStepTrailingIconSize,
            ),
            onPressed: () {},
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              key: Key('${machineUtilityStep.machineUtilityStepTitle}title'),
              children: [
                Text(
                  machineUtilityStep.machineUtilityStepTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  width: MachineDashboardSizes
                      .machineDashboardEditStepTitleIconSpacing,
                ),
                _buildStepProcessIcon(
                  machineUtilityStep.machineUtilityStepProcess,
                ),
              ],
            ),
            const SizedBox(
              width: MachineDashboardSizes
                  .machineDashboardEditStepTextFieldTitleSpacing,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    key: Key(
                        '${machineUtilityStep.machineUtilityStepTitle}tempTextField'),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MachineDashboardSizes
                            .machineDashboardEditStepTextFieldWidth,
                        child: CommonTextFormField(
                          labelText: MachineDashboardUiStrings
                              .machineDashboardEditProgramDialogTemperature,
                          fillColor: Colors.white,
                          borderFocusColorBorder: AppTheme.greyPrimary100,
                          labelTextFontSize: MachineDashboardSizes
                              .machineDashboardEditStepLabelTextFontSize,
                          controller: tempTextFieldController,
                          keyboardType: TextInputType.number,
                          contentPadding: EdgeInsets.zero,
                          validator: Validators.isDigit(UiStrings.digitOnly),
                        ),
                      ),
                      Text(
                        MachineDashboardUiStrings
                            .machineDashboardTemperatureCelciusSymbol,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: MachineDashboardSizes
                        .machineDashboardEditStepTextFieldSpacing,
                  ),
                  Row(
                    key: Key(
                        '${machineUtilityStep.machineUtilityStepTitle}durTextField'),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MachineDashboardSizes
                            .machineDashboardEditStepDurationTextFieldWidth,
                        child: CommonTextFormField(
                          labelText: MachineDashboardUiStrings
                              .machineDashboardEditProgramDialogDuration,
                          fillColor: Colors.white,
                          borderFocusColorBorder: AppTheme.greyPrimary100,
                          labelTextFontSize: MachineDashboardSizes
                              .machineDashboardEditStepLabelTextFontSize,
                          controller: durationTextFieldController,
                          keyboardType: TextInputType.number,
                          contentPadding: EdgeInsets.zero,
                          validator: Validators.isDigit(UiStrings.digitOnly),
                        ),
                      ),
                      Text(
                        MachineDashboardUiStrings
                            .machineDashboardEditProgramDialogHr,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          key: Key('${machineUtilityStep.machineUtilityStepTitle}trailing'),
          onPressed: () async {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CommonDialog(
                key: const Key('startApStepDialog'),
                cancelButtonTile: MachineDashboardUiStrings
                    .machineDashboardEditProgramDialogNo,
                contentText: MachineDashboardUiStrings.contentDialog(index),
                submitButtonTile: MachineDashboardUiStrings
                    .machineDashboardEditProgramDialogSubmitStartAtStep,
                titleText: MachineDashboardUiStrings.startAtTitle(index),
                cancelButtonColor: AppTheme.greyPrimary400,
                submitButtonColor: AppTheme.redPrimary100,
                cancelButtonCallBack: () {
                  Navigator.pop(context);
                },
                submitButtonCallBack: () {},
              ),
            );
          },
          icon: const Icon(
            PhosphorIcons.xCircle,
            color: AppTheme.redPrimary100,
            size:
                MachineDashboardSizes.machineDashboardEditStepTrailingIconSize,
          ),
        ),
      ),
    );
  }

  Widget _buildStepProcessIcon(MachineUtilityStepProcess stepProcess) {
    switch (stepProcess) {
      case MachineUtilityStepProcess.COOLING:
        return const Icon(
          PhosphorIcons.arrowDownRight,
          key: Key('coolingStepIcon'),
          color: AppTheme.bluePrimary,
        );
      case MachineUtilityStepProcess.HEATING:
        return const Icon(
          PhosphorIcons.arrowUpRight,
          key: Key('heatingStepIcon'),
          color: AppTheme.redPrimary100,
        );
      case MachineUtilityStepProcess.MAINTAIN:
        return const Icon(
          PhosphorIcons.arrowRight,
          key: Key('maintainStepIcon'),
          color: AppTheme.greenPrimary100,
        );
    }
  }
}
