import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';  // ضع السطر الصحيح فقط
import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flower_app/features/app_sections/best_seller/presentation/cubit/best_seller_cubit.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<LoginCubit>().state;

    return BlocProvider<BestSellerCubit>(
      create: (_) => getIt<BestSellerCubit>(),
      child: BlocProvider<AddToCartCubit>(
        create: (_) => getIt<AddToCartCubit>(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    product.imgCover ?? "",
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "EGP ${product.priceAfterDiscount}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "${product.price}",
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "50%",
                            style: TextStyle(color: Colors.green, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          final productId = product.id ?? '';

                          if (authState is LoginSuccessState) {
                            context.read<AddToCartCubit>().addToCart(
                              AddToCartParameters(product: productId),
                            );
                          } else {
                            DialogUtils.showMessage(
                              context,
                              'Please log in to add products to your cart.',
                              Icon: (icon) { Icon(Icons.login, color: ColorManager.appColor); },
                              posActionName: 'Login',
                              posAction: () => Navigator.pushNamed(
                                context,
                                Routes.loginRoute,

                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: ColorManager.appColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text("Add to cart", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
