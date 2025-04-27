import 'package:flutter/material.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/resources/color_manager.dart';

class BuildAlert extends StatelessWidget {
  const BuildAlert({super.key, required this.openLocationSettings});
final void Function() openLocationSettings;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(lang.locationAccessDenied),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            openLocationSettings();
          },
          child: Text(lang.allow),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            lang.cancel,
            style: TextStyle(
              color: ColorManager.appColor,
            ),
          ),
        ),
      ],
    );
  }
}
