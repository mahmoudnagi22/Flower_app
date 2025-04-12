import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/app_sections/cart/presentation/cubit/update_quantity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../auth/signUp/presentation/widgets/custom_button.dart';
import '../widgets/cart_item.dart';
import '../widgets/location.dart';

class CartScreen extends StatelessWidget {
   CartScreen({super.key});

  UpdateQuantityCubit viewModel = getIt.get<UpdateQuantityCubit>();

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
            Expanded(child: CartItem()),
            Row(
              children: [
                Text(
                  'Sub Total',
                  style: TextStyle(color: ColorManager.gray, fontSize: 16),
                ),
                Spacer(),
                Text(
                  '100\$',
                  style: TextStyle(color: ColorManager.gray, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Sub Total',
                  style: TextStyle(color: ColorManager.gray, fontSize: 16),
                ),
                Spacer(),
                Text(
                  '100\$',
                  style: TextStyle(color: ColorManager.gray, fontSize: 16),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Total',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                Spacer(),
                Text(
                  '110\$',
                  style: TextStyle(color: ColorManager.black, fontSize: 16,fontWeight: FontWeight.w500),
                ),
              ],
            ),
            50.verticalSpace,
            CustomButton(onPressed: () {
            }, text: 'Checkout')
          ],
        ),
      ),
    );
  }
}
