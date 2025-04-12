import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../home/screen/widgets/location.dart';
import '../widgets/cart_item.dart';
import '../widgets/location.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.pinkAccent,
        title: const Text('Cart (3 items)'),
        ),

      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LocationWithoutPadding(),
            20.verticalSpace,
            Expanded(child: CartItem())

          ],
        ),
      ),
    );
  }
}
