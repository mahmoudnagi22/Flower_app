import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cubits/local_cubit/local_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LocalizationCubit.get(context);
    var lang = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),

            Text(
              lang!.lang,
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
            ),

            SizedBox(height: 25.h),

            CustomDropdown<String>(
              decoration: const CustomDropdownDecoration(
                expandedShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    spreadRadius: .5,
                  ),
                ],
                closedShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    spreadRadius: .5,
                  ),
                ],
                closedFillColor: Colors.white,
                expandedFillColor: Colors.white,
                expandedSuffixIcon: Icon(
                  Icons.arrow_drop_up_outlined,
                  color: ColorManager.appColor,
                ),
                closedSuffixIcon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: ColorManager.appColor,
                ),
              ),
              items: const ["English", "عربى"],
              initialItem: cubit.state.language == "ar" ? "عربى" : "English",
              onChanged: (value) {
                if (value == "English") cubit.changeLanguage("en");
                if (value == "عربى") cubit.changeLanguage("ar");
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.editProfileRoute);
              },
              child: Image.asset('assets/images/noto-v1_pen.png', height: 30.h),
            ),
          ],
        ),
      ),
    );
  }
}
