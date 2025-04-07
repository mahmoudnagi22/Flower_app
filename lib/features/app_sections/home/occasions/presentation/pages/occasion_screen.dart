import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/home/occasions/presentation/cubit/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/utils/status.dart';

class OccasionScreen extends StatelessWidget {
  OccasionScreen({super.key});

  OccasionCubit viewModel = getIt.get<OccasionCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
            const Text('Occasion'),
            Text(
              'Bloom with our exquisite best sellers',
              style: TextStyle(fontSize: 13, color: ColorManager.gray),
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
                          final selectedOccasion = state.occasionList?[index];
                          context.read<OccasionCubit>().getProducts(
                            ProductFilter(occasionId: selectedOccasion?.id)
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
                                  return Card(
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
                                                  "EGP ${state.products![index].priceAfterDiscount}",
                                                  style: TextStyle(
                                                    color: ColorManager.black,
                                                    fontSize: 14.sp,
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
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: 147.w,
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                color: ColorManager.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(25.r),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    IconsAssets.cart,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    "Add to cart",
                                                    style: TextStyle(
                                                      color: ColorManager.white,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
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
