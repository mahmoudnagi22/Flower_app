import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/resources/assets_manager.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return  Padding(
      padding:  REdgeInsets.only(top: 20 ,bottom: 10),
      child: Row(
        children: [
          Image.asset(IconsAssets.location ,width: 20.w,height: 20.h,),
          SizedBox(width: 5.w,),
          Text("${lang!.deliverTO} 2XVP+XC - Sheikh Zayed " , style: GoogleFonts.inter(
            fontWeight: FontWeight.w500 ,fontSize: 14.sp,
          ),),
          SizedBox(width: 5.w,),
          Image.asset(IconsAssets.arrow ,width: 16.w,height: 16.h,),
        ],
      ),
    );
  }
}
