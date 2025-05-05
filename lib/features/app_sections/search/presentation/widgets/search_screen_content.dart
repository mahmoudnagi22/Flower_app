import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/l10n/app_localizations.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/utils/status.dart';
import '../../../categories/presentation/widgets/custom_search.dart';
import '../cubit/search_cubit.dart';

class SearchScreenContent extends StatelessWidget {
  const SearchScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomSearch(
          onFieldSubmitted: (text) {
            context.read<SearchCubit>().fetchProducts(text);
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.searchState == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.appColor),
            );
          } else if (state.searchState == Status.error) {
            return Center(
              child: Text(state.searchError ?? 'Unexpected Error'),
            );
          } else if (state.searchState == Status.success) {
            final products = state.searchList?.products ?? [];
            if (products.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.all(10.sp),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(0),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: ColorManager.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: ColorManager.textField.withOpacity(.7),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        product.imgCover ?? '',
                                        width: double.infinity,
                                        height: 200.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          product.title ?? '',
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
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${lang!.currency} ${product
                                                .priceAfterDiscount}",
                                            style: TextStyle(
                                              color: ColorManager.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            "${product.price}",
                                            style: TextStyle(
                                              color: ColorManager.gray,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                              decoration: TextDecoration
                                                  .lineThrough,
                                              decorationColor: ColorManager
                                                  .gray,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            "${product.discount}%",
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        }, childCount: products.length),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('There are no Products',
                style: TextStyle(color: ColorManager.appColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,),),);
            }
          }
          return const SizedBox();
        },)
    );
  }
}