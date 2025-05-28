import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/core/widget/custom_card.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/custom_search.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/floating_button.dart';
import 'package:flower_app/features/app_sections/search/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/status.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CategoriesCubit>()..getCategories()),
        BlocProvider(create: (_) => getIt<AddToCartCubit>()),
      ],
      child: Scaffold(
        backgroundColor:    ColorManager.white,
        appBar: _buildAppBar(context),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          buildWhen: (prev, curr) =>
          prev.products != curr.products ||
              prev.productsState != curr.productsState ||
              prev.categoriesState != curr.categoriesState,
          builder: (context, state) {
            if (state.categoriesState == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.appColor),
              );
            } else if (state.categoriesState == Status.error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                DialogUtils.showError(context, state.categoriesError ?? '');
              });
              return const SizedBox();
            } else if (state.categoriesState == Status.success) {
              return _buildCategoryContent(context, state, lang);
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchScreen()),
              ),
              child: IgnorePointer(child: CustomSearch()),
            ),
          ),
          5.horizontalSpace,
          Expanded(
            child: InkWell(
              onTap: () async {
                final selectedFilter = await FloatingButton.showModalBottomSheetList(context);
                if (selectedFilter != null) {
                  context.read<CategoriesCubit>().getProducts(selectedFilter);
                }
              },
              child: Container(
                width: 64.w,
                height: 45.h,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.gray),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    IconsAssets.filter,
                    width: 18.w,
                    height: 12.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(BuildContext context, CategoriesState state, AppLocalizations? lang) {
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
                final selectedCategory = state.categoryList?[index].id;
                context.read<CategoriesCubit>().getProducts(
                  ProductFilter(categoryId: selectedCategory),
                );
              },
              tabs: state.categoryList
                  ?.map((category) => Tab(text: category.name ?? ''))
                  .toList() ??
                  [],
            ),
          ),
          10.verticalSpace,
          if (state.productsState == Status.loading)
            const Center(
              child: CircularProgressIndicator(color: ColorManager.appColor),
            ),
          if (state.productsState == Status.success)
            Expanded(
              child: _buildProductsGrid(context, state, lang),
            ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context, CategoriesState state, AppLocalizations? lang) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: state.products?.length ?? 0,
      itemBuilder: (context, index) {
        final product = state.products![index];
        return ProductCard(
          product: product,
          onTap: () => Navigator.pushNamed(
            context,
            Routes.productDetails,
            arguments: product,
          ),
        );
      },
    );
  }
}
