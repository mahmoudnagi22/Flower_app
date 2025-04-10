import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/routes_manager/routes.dart';

class TitleOfGroup extends StatelessWidget {
  String nameOfGroup;
  String routesNamed;
   TitleOfGroup({super.key, required this.nameOfGroup , required this.routesNamed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nameOfGroup ,style: GoogleFonts.inter(
            fontWeight: FontWeight.w500 ,fontSize: 18.sp,
          ),),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, routesNamed);
            },
            child: Text("View All" ,style: GoogleFonts.inter(
              fontWeight: FontWeight.w500 ,fontSize: 12.sp,
              color: ColorManager.bank,
              decoration: TextDecoration.underline,
              decorationColor: ColorManager.bank,
            ),),
          ),

        ],
      ),
    );
  }
}
