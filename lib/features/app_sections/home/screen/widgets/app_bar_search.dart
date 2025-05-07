import 'package:flower_app/core/cubits/local_cubit/local_cubit.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../search/presentation/pages/search_screen.dart';

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
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
              left: LocalizationCubit.get(context).state.language == "ar" ? 0 : 20.w,
              right: LocalizationCubit.get(context).state.language == "ar" ? 20.w : 0,
            ),
            child:InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SearchScreen()),
                );
              },
              child: IgnorePointer(
                child: TextFormField(
                  cursorColor: ColorManager.textField,
                  style: GoogleFonts.inter(color: ColorManager.textField),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager.textField,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager.textField,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager.textField,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager.textField,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 1, color: ColorManager.error),
                    ),
                    prefixIcon: ImageIcon(
                      AssetImage(IconsAssets.icSearch),
                      color: ColorManager.textField,
                    ),
                    hintText: lang!.search,
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
