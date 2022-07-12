import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/widgets/utility/common_button.dart';
import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.titleText,
    required this.contentText,
    required this.submitButtonTile,
    required this.cancelButtonTile,
    required this.submitButtonColor,
    required this.cancelButtonColor,
    required this.cancelButtonCallBack,
    required this.submitButtonCallBack,
  }) : super(key: key);

  final String titleText;
  final Widget contentText;
  final String submitButtonTile;
  final String cancelButtonTile;
  final Color submitButtonColor;
  final Color cancelButtonColor;
  final VoidCallback cancelButtonCallBack;
  final VoidCallback submitButtonCallBack;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.commonDialogBorderRadius),
        ),
      ),
      title: Text(
        titleText,
        style: Theme.of(context)
            .textTheme
            .button!
            .copyWith(fontWeight: FontWeight.bold),
        key: const Key('titleDialog'),
      ),
      content: contentText,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonButton(
              key: const Key('cancelButtonDialog'),
              buttonTitle: cancelButtonTile,
              onPress: cancelButtonCallBack,
              fontSize: Theme.of(context).textTheme.button,
              buttonColor: cancelButtonColor,
            ),
            const SizedBox(
              width: Sizes.commonDialogButtonPadding,
            ),
            CommonButton(
              key: const Key('submitButtonDialog'),
              buttonTitle: submitButtonTile,
              onPress: submitButtonCallBack,
              fontSize: Theme.of(context).textTheme.button,
              buttonColor: submitButtonColor,
            ),
          ],
        )
      ],
    );
  }
}
