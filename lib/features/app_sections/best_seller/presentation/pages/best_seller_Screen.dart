import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/core/widget/custom_card.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/app_sections/best_seller/presentation/cubit/best_seller_cubit.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<BestSellerCubit>()..getBestSellerProducts()),
        BlocProvider(create: (_) => getIt<AddToCartCubit>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Best Seller Products'),
        ),
        body: BlocListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartLoadingState) {
              DialogUtils.showLoading(context, "Loading...");
            } else if (state is AddToCartSuccessState) {
              DialogUtils.hideLoading(context);
              DialogUtils.showSuccess(context, "✅ Product has been added to cart");
            } else if (state is AddToCartErrorState) {
              DialogUtils.hideLoading(context);
              DialogUtils.showError(context, state.massage);
            }
          },
          child: BlocBuilder<BestSellerCubit, BestSellerState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.loaded:
                  if (state.bestSellerList.isEmpty) {
                    return const Center(
                      child: Text('No best seller products found.'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.bestSellerList.length,
                    itemBuilder: (context, index) {
                      final product = state.bestSellerList[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.productDetails,
                            arguments: product,
                          );
                        },
                      );
                    },
                  );

                case Status.error:
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'An error occurred',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );

                default:
                  return const Center(child: Text('Please wait...'));
              }
            },
          ),
        ),
      ),
    );
  }
}
