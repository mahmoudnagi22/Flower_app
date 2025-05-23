import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/l10n/app_localizations.dart';

class CustomSearch extends StatelessWidget {
   CustomSearch({super.key,this.onFieldSubmitted});

  void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: lang!.search,
          hintStyle: TextStyle(color: ColorManager.gray),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: ColorManager.appColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: onFieldSubmitted
      ),
    );
  }
}
