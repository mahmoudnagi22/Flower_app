import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) => false,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  CircularProgressIndicator(),
                  SizedBox(width: 20.w),
                  Text("Loading..."),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showErrorDialog(BuildContext context , String massage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result)async => false,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  Icon(Icons.error_outline ,size: 50, color: ColorManager.error,),
                  SizedBox(width: 20.w),
                  Text( massage),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
