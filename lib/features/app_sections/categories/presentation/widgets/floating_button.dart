import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/app_sections/occasions/presentation/cubit/occasion_cubit.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import 'filter_item.dart';

class FloatingButton extends StatelessWidget {
  FloatingButton({super.key});

  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 117.w,
      height: 34.h,
      child: FloatingActionButton(
        backgroundColor: ColorManager.appColor,
        onPressed: () {
          showModalBottomSheetList(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: ColorManager.white),
            5.horizontalSpace,
            const Text(
              'Filter',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<ProductFilter?>  showModalBottomSheetList(BuildContext context) async{
    ProductFilter? selectedFilter;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        return SizedBox(
          height: height * 0.65,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.appColor,
                  ),
                ),
                20.verticalSpace,
                FilterList(
                  onSelected: (value) {
                    selectedFilter?.filter = value;
                  },
                ),
                20.verticalSpace,
                CustomButton(
                  onPressed: () {
                    final filter = ProductFilter(
                      filter: selectedFilter?.filter ?? 'price',
                    );
                    getIt<CategoriesCubit>().getProducts(filter);
                    print('success');
                    // context.read<CategoriesCubit>().getProducts(ProductFilter(filter: filter.filter));
                    Navigator.pop(context);
                  },
                  text: 'Filter',
                ),
              ],
            ),
          ),
        );
      },
    );
    return null;
  }
}
