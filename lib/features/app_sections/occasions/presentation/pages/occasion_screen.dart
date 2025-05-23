import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/utils/status.dart';
import '../../../add_to_cart/data/model/add_to_cart_parameters.dart';
import '../../../add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import '../../../add_to_cart/presentation/cubit/add_to_cart_state.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../categories/domain/entities/product_filter.dart';
import '../cubit/occasion_cubit.dart';


class OccasionScreen extends StatelessWidget {
  OccasionScreen({super.key});

  OccasionCubit viewModel = getIt.get<OccasionCubit>();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
             Text(lang!.occasions),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Bloom with our exquisite best sellers',
                style: TextStyle(fontSize: 13, color: ColorManager.gray),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<OccasionCubit>()..getOccasions(),
        child: BlocBuilder<OccasionCubit, OccasionState>(
          builder: (context, state) {
            if (state.occasionState == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.appColor),
              );
            } else if (state.occasionState == Status.error) {
              DialogUtils.showError(context, state.occasionError ?? '');
            } else if (state.occasionState == Status.success) {
              return Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTabController(
                      length: state.occasionList?.length ?? 0,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: ColorManager.appColor,
                        dividerColor: Colors.transparent,
                        labelColor: ColorManager.appColor,
                        unselectedLabelColor: ColorManager.gray,
                        tabAlignment: TabAlignment.center,
                        onTap: (index) {
                          final selectedOccasion =
                              state.occasionList?[index].id;
                          context.read<OccasionCubit>().getProducts(
                            ProductFilter(occasionId: selectedOccasion),
                          );
                        },
                        tabs:
                            state.occasionList?.map((occasion) {
                              return Tab(text: occasion.name ?? '');
                            }).toList() ??
                            [],
                      ),
                    ),
                    10.verticalSpace,
                    if (state.productsState == Status.loading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.appColor,
                        ),
                      ),
                    if (state.productsState == Status.success) ...[
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.all(0),
                              sliver: SliverGrid(
                                delegate: SliverChildBuilderDelegate((
                                  context,
                                  index,
                                ) {
                                  return GestureDetector(
                                      onTap: (){
                                    Navigator.pushNamed(
                                      context,
                                      Routes.productDetails,
                                      arguments: state.products![index],
                                    );
                                  },
                                  child: Card(
                                    color: ColorManager.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: ColorManager.textField
                                            .withOpacity(.7),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              state.products![index].imgCover
                                                  .toString(),
                                              width: double.infinity,
                                              height: 200.h,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                state.products![index].title
                                                    .toString(),
                                                style: TextStyle(
                                                  color: ColorManager.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${lang.currency} ${state.products![index].priceAfterDiscount}",
                                                  style: TextStyle(
                                                    color: ColorManager.black,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "${state.products![index].price}",
                                                  style: TextStyle(
                                                    color: ColorManager.gray,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                    decorationColor:
                                                        ColorManager.gray,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "${state.products![index].discount}%",
                                                  style: TextStyle(
                                                    color: ColorManager.green,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          BlocProvider(
                                            create: (_) => AddToCartCubit(),
                                            child: BlocListener<AddToCartCubit, AddToCartState>(
                                              listener: (context, state) {
                                                if(state is AddToCartLoadingState){
                                                  DialogUtils.showLoading(context, lang.lang);
                                                }
                                                if (state is AddToCartSuccessState) {
                                                  DialogUtils.hideLoading(context);
                                                  DialogUtils.showSuccess(context, "✅ Product has been added to cart");
                                                } else if (state is AddToCartErrorState) {
                                                  DialogUtils.hideLoading(context);
                                                  DialogUtils.showError(context, state.massage);
                                                }
                                              },
                                              child: Builder(
                                                builder: (innerContext) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      final productId = state.products![index].id ?? '';
                                                      innerContext.read<AddToCartCubit>().addToCart(
                                                        AddToCartParameters(product: productId),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 147.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        color: ColorManager.appColor,
                                                        borderRadius: BorderRadius.circular(25.r),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            IconsAssets.cart,
                                                            height: 18,
                                                            width: 18,
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          Text(
                                                            lang.addToCart,
                                                            style: TextStyle(
                                                              color: ColorManager.white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),);
                                }, childCount: state.products?.length),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: 0.75,
                                    ),
                              ),
                            ),
                          ],
                        ),
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
    );
  }
}
