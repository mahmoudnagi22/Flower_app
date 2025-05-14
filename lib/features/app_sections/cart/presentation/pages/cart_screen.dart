import 'dart:developer';

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

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CartCubit>()..getCarts(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              int itemCount = 0;
              if (state.cartStatus == Status.success) {
                itemCount = state.cartsList?.length ?? 0;
              }
              return Text('Cart ($itemCount items)');
            },
          ),
        ),
        body: CartItem(),
      ),
    );
  }
}
