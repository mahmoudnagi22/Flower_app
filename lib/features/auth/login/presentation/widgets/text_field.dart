import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/widget/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String validatorMessage;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validation;

  const BuildTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validatorMessage,
    this.validation,
    this.autovalidateMode,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: GoogleFonts.inter(
          color: ColorManager.gray,
          fontWeight: FontWeight.w400,
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(
          color: ColorManager.textField,
          fontSize: 14.sp,
        ),
        errorText: errorText,
        errorStyle: GoogleFonts.inter(
          color: ColorManager.error,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: ColorManager.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.gray),
        ),
      ),
      validator: (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            if (widget.validation != null) {
              errorText = widget.validation!(value);
            } else {
              errorText = null;
            }
          });
        });
        return errorText;
      },
    );
  }
}
