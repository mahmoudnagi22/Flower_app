import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/app_sections/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower_app/features/checkout_page/presentation/screens/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/utils/status.dart';
import '../../../../auth/signUp/presentation/widgets/custom_button.dart';
import 'location.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key});

  CartCubit viewModel = getIt.get<CartCubit>();

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map<int, int> localQuantities = {};

  @override
  Widget build(BuildContext context) {
    var lang =AppLocalizations.of(context);
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.cartStatus == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.appColor,
                  ),
                );
              } else if (state.cartStatus == Status.error) {
                return Center(
                  child: Text(
                    state.updateError ?? '',
                    style: const TextStyle(
                      color: ColorManager.appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else if (state.cartStatus == Status.success) {
                final carts = state.cartsList ?? [];

                final totalPrice = carts.asMap().entries.fold<double>(0, (
                  previousValue,
                  entry,
                ) {
                  final index = entry.key;
                  final item = entry.value;
                  final quantity = localQuantities[index] ?? item.quantity ?? 1;
                  final price = item.product?.price ?? 0;
                  return previousValue + price * quantity;
                });
                return Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    children: [
                      const LocationWithoutPadding(),
                      20.verticalSpace,
                      Expanded(
                        child:
                            carts.isNotEmpty
                                ? ListView.builder(
                                  itemCount: state.cartsList?.length,
                                  itemBuilder: (context, index) {
                                    final cartItem =
                                        state.cartsList![index].product;
                                    localQuantities[index] ??=
                                        state.cartsList![index].quantity as int;
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
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: Image.network(
                                                  state
                                                          .cartsList![index]
                                                          .product
                                                          ?.imgCover ??
                                                      '',
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
                                                        cartItem?.title ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      subtitle: Text(
                                                        cartItem?.description ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              ColorManager.gray,
                                                        ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      trailing: InkWell(
                                                        onTap: () async {
                                                          await context
                                                              .read<CartCubit>()
                                                              .deleteItem(
                                                                cartItem?.id ??
                                                                    '',
                                                              );
                                                        },
                                                        child: SvgPicture.asset(
                                                          IconsAssets.delete,
                                                        ),
                                                      ),
                                                    ),
                                                    10.verticalSpace,
                                                    Row(
                                                      children: [
                                                        20.horizontalSpace,
                                                        Text(
                                                          cartItem?.price
                                                                  .toString() ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                              ),
                                                        ),
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            if (localQuantities[index]! >
                                                                1) {
                                                              setState(() {
                                                                localQuantities[index] =
                                                                    localQuantities[index]! -
                                                                    1;
                                                                widget.viewModel
                                                                    .updateQuantity(
                                                                      cartItem?.id ??
                                                                          '',
                                                                      localQuantities[index]!,
                                                                    );
                                                              });
                                                            }
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                                IconsAssets
                                                                    .decrement,
                                                              ),
                                                        ),
                                                        10.horizontalSpace,
                                                        Text(
                                                          localQuantities[index]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        10.horizontalSpace,
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              localQuantities[index] =
                                                                  localQuantities[index]! +
                                                                  1;
                                                              widget.viewModel
                                                                  .updateQuantity(
                                                                    cartItem?.id ??
                                                                        '',
                                                                    localQuantities[index]!,
                                                                  );
                                                            });
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                                IconsAssets
                                                                    .increment,
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
                                )
                                :  Center(
                                  child: Text(
                                    lang!.cartEmpty,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorManager.appColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                      ),
                      if (carts.isNotEmpty) ...[
                        Row(
                          children: [
                            Text(
                             lang!.total,
                              style: TextStyle(
                                color: ColorManager.gray,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${totalPrice.toStringAsFixed(0)}\$',
                              style: TextStyle(
                                color: ColorManager.gray,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              lang.deliveryFee,
                              style: TextStyle(
                                color: ColorManager.gray,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '10\$',
                              style: TextStyle(
                                color: ColorManager.gray,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                             Text(
                              lang.total,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${(totalPrice + 10).toStringAsFixed(0)}\$',
                              style: const TextStyle(
                                color: ColorManager.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        50.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckoutScreen(),
                              ),
                            );
                          },
                          text: lang.checkOut,
                        ),
                      ],
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        30.verticalSpace,
      ],
    );
  }
}
