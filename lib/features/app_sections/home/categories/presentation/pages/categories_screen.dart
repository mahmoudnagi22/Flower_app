import 'package:flower_app/features/app_sections/home/categories/presentation/widgets/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/utils/dialog_utils.dart';
import '../../../../../../core/utils/status.dart';
import '../../../occasions/presentation/cubit/occasion_cubit.dart';
import '../cubit/categories_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(flex: 4, child: CustomSearch()),
            5.horizontalSpace,
            Expanded(
              child: Container(
                width: 64.w,
                height: 48.h,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.gray),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.filter_list_rounded),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<CategoriesCubit>()..getCategories(),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state.categoriesState == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.appColor),
              );
            } else if (state.categoriesState == Status.error) {
              DialogUtils.showError(context, state.categoriesError ?? '');
            } else if (state.categoriesState == Status.success) {
              return Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    DefaultTabController(
                      length: state.categoryList?.length ?? 0,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: ColorManager.appColor,
                        dividerColor: Colors.transparent,
                        labelColor: ColorManager.appColor,
                        unselectedLabelColor: ColorManager.gray,
                        tabAlignment: TabAlignment.center,
                        onTap: (index) {
                          final selectedCategory = state.categoryList?[index];
                          if (selectedCategory != null &&
                              selectedCategory.id != null) {
                            context.read<CategoriesCubit>().getCategoriesById(
                              selectedCategory.id!,
                            );
                          }
                        },
                        tabs:
                            state.categoryList?.map((categories) {
                              return Tab(text: categories.name ?? '');
                            }).toList() ??
                            [],
                      ),
                    ),
                    30.verticalSpace,

                    if (state.categoriesByIdState == Status.loading)
                      const Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.appColor,
                            ),
                          ),
                        ],
                      ),

                    if (state.categoriesByIdState == Status.success) ...[
                      Text(
                        state.categoryById?.category?.name ??
                            "No name available",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.verticalSpace,
                      Image.network(
                        state.categoryById?.category?.image ?? '',
                        // height: 150,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 100);
                        },
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
