import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../data/model/Categories.dart';

class CategoriesItem extends StatelessWidget {
  final Categories category;
  const CategoriesItem({super.key ,required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  REdgeInsets.only(right: 14),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bGCategories,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                width: 68.w,
                height: 64.h,
                child: Center(child: Image.network(category.image ?? "", width: 24.w, height: 24.h),) ,
              ),
        
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 8),
          child: Text(category.name ?? "" , style: GoogleFonts.inter(
            fontWeight: FontWeight.w400 ,fontSize: 14.sp,
          ),maxLines: 1
            ,),
        )
      ],
    );
  }
}
