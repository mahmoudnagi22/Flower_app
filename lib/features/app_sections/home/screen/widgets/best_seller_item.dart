import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/BestSeller.dart';

class BestSellerItem extends StatelessWidget {
  final BestSeller bestSeller;
  const BestSellerItem({super.key ,required this.bestSeller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Image.network(bestSeller.imgCover ?? "",height: 151.h,width: 131.w,),
        ),
        Text(bestSeller.title ?? "" , style:  GoogleFonts.inter(
          fontWeight: FontWeight.w400,fontSize: 12.sp,
        ),),
        Text("${bestSeller.price} EGP" , style:  GoogleFonts.inter(
          fontWeight: FontWeight.w500,fontSize: 14.sp
        ),)
      ],
    );
  }
}
