import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText({super.key,required this.onPressed,required this.child});
  void Function()? onPressed;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child);
  }
}
