import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
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
                          child: Image.asset(
                            'assets/images/Image.png',
                            width: 96.w,
                            height: 101.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Red roses',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  '15 Pink Rose Bouquet',
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
                                  const Text(
                                    'EGP 600',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (quantity > 1) {
                                        quantity--;
                                        setState(() {
                                          quantity = quantity;
                                        });
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      IconsAssets.decrement,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  InkWell(
                                    onTap: () {
                                      quantity++;
                                      setState(() {
                                        quantity = quantity;
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
