import 'package:flower_app/core/cubits/local_cubit/local_cubit.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/app_sections/search/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({super.key});

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final isArabic = LocalizationCubit.get(context).state.language == "ar";

    return Row(
      children: [
        Image.asset(ImageAssets.layer, height: 20.h, width: 20.w),
        Text(
          "Flowery",
          style: GoogleFonts.imFellEnglish(
            color: ColorManager.bank,
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: isArabic ? 0 : 20.w,
              right: isArabic ? 20.w : 0,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: IgnorePointer(
                child: TextFormField(
                  cursorColor: ColorManager.textField,
                  style: GoogleFonts.inter(color: ColorManager.textField),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    focusedBorder: _border(ColorManager.textField),
                    enabledBorder: _border(ColorManager.textField),
                    disabledBorder: _border(ColorManager.textField),
                    errorBorder: _border(ColorManager.error),
                    focusedErrorBorder: _border(ColorManager.textField),
                    prefixIcon: ImageIcon(
                      AssetImage(IconsAssets.icSearch),
                      color: ColorManager.textField,
                    ),
                    hintText: lang.search,
                    hintStyle: GoogleFonts.inter(
                      color: ColorManager.textField,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
