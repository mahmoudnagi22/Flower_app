import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/utils/status.dart';
import 'package:flower_app/features/app_sections/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../auth/signUp/presentation/widgets/custom_button.dart';
import '../widgets/cart_item.dart';
import '../widgets/location.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartCubit viewModel = getIt.get<CartCubit>();

  @override
  void initState() {
    super.initState();
    viewModel.getCarts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart (3 items)'),
        ),

        body: BlocBuilder<CartCubit, CartState>(
          bloc: viewModel,
          builder: (context, state) {
            if (state.cartStatus == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.appColor,),);
            } else if (state.cartStatus == Status.error) {
              return Center(child: Text(state.updateError ?? '',
                style: const TextStyle(color: ColorManager.appColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),),);
            } else if (state.cartStatus == Status.success) {
              return Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const LocationWithoutPadding(),
                    20.verticalSpace,
                    Expanded(child: CartItem(state: state,)),
                    Row(
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(color: ColorManager.gray,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        Text(
                          '100\$',
                          style: TextStyle(color: ColorManager.gray,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(color: ColorManager.gray,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        Text(
                          '100\$',
                          style: TextStyle(color: ColorManager.gray,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      children: [
                        Text('Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight
                              .w500),),
                        Spacer(),
                        Text(
                          '110\$',
                          style: TextStyle(color: ColorManager.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    50.verticalSpace,
                    CustomButton(onPressed: () {}, text: 'Checkout')
                  ],
                ),
              );
            }
            return SizedBox();
          },)
    );
  }
}
