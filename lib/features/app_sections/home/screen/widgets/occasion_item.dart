import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/features/app_sections/home/data/model/Occasions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OccasionItem extends StatelessWidget {
  final Occasions occasions;
  const OccasionItem({super.key , required this.occasions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Image.network(occasions.image ?? "",height: 151.h,width: 131.w,),
        ),
        Text(occasions.name ?? "" , style:  GoogleFonts.inter(
            fontWeight: FontWeight.w500,fontSize: 14.sp
        ),)
      ],
    );
  }
}
