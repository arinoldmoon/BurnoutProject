import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class MachineDashboardStatusIdleButton extends StatelessWidget {
  const MachineDashboardStatusIdleButton(
      {Key? key,
      required this.buttonText,
      required this.icon,
      required this.onTap})
      : super(key: key);

  final String buttonText;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: AppTheme.yellowPrimary,
            ),
            Text(
              buttonText,
              style: Theme.of(context).textTheme.button,
            )
          ],
        ),
      ),
    );
  }
}
