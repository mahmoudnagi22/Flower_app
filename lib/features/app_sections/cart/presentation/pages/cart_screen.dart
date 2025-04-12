import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_item.dart';
import '../widgets/location.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
