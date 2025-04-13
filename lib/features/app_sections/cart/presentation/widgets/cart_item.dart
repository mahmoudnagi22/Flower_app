import 'package:flower_app/features/app_sections/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key, required this.state});

  CartState state;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map<int, int> localQuantities = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.state.cartsList?.length,
            itemBuilder: (context, index) {
              final cartItem = widget.state.cartsList![index];


              localQuantities[index] ??= cartItem.quantity as int;

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.sp),
                    width: double.infinity,
                    height: 117.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.black,
                        width: 0.5.w,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            cartItem.product?.imgCover ?? '',
                            width: 96.w,
                            height: 101.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  cartItem.product?.title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  cartItem.product?.description ?? '',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.gray,
                                  ),
                                ),
                                trailing: Image.asset(
                                  IconsAssets.delete,
                                  width: 16.w,
                                  height: 18.h,
                                ),
                              ),
                              10.verticalSpace,
                              Row(
                                children: [
                                  20.horizontalSpace,
                                  Text(
                                    cartItem.product?.price.toString() ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (localQuantities[index]! > 1) {
                                        setState(() {
                                          localQuantities[index] =
                                              localQuantities[index]! - 1;
                                        });
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      IconsAssets.decrement,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    localQuantities[index].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        localQuantities[index] =
                                            localQuantities[index]! + 1;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      IconsAssets.increment,
                                    ),
                                  ),
                                  20.horizontalSpace,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                ],
              );
            },
          ),
        ),
        30.verticalSpace,
      ],
    );
  }
}

