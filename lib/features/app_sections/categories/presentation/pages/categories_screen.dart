import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/core/utils/status.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/floating_button.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_state.dart';
import 'package:flower_app/features/app_sections/search/presentation/pages/search_screen.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/custom_search.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesCubit>()..getCategories(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton:  FloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SearchScreen())
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

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) =>
      previous.products != current.products ||
          previous.productsState != current.productsState,
      builder: (context, state) {
        switch (state.categoriesState) {
          case Status.loading:
            print('Changing products state to: ${state.productsState}');
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.appColor),
            );
          case Status.error:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              DialogUtils.showError(context, state.categoriesError ?? '');
            });
            return const SizedBox();
          case Status.success:
            return _buildSuccessView(context, state);
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildSuccessView(BuildContext context, CategoriesState state) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryTabs(context, state),
          10.verticalSpace,
          _buildProductsSection(context, state),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context, CategoriesState state) {
    return DefaultTabController(
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
        tabs: state.categoryList?.map((category) {
          return Tab(text: category.name ?? '');
        }).toList() ?? [],
      ),
    );
  }

  Widget _buildProductsSection(BuildContext context, CategoriesState state) {
    switch (state.productsState) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(color: ColorManager.appColor),
        );
      case Status.success:
        return Expanded(
          child: _buildProductsGrid(context, state),
        );
      case Status.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogUtils.showError(context, state.categoriesError ?? '');
        });
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget _buildProductsGrid(BuildContext context, CategoriesState state) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildProductCard(context, state, index),
              childCount: state.products?.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, CategoriesState state, int index) {
    final lang = AppLocalizations.of(context);
    final product = state.products![index];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product,
        );
      },
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
                  product.imgCover.toString(),
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    product.title.toString(),
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildPriceRow(lang, product),
              ),
              SizedBox(height: 5.h),
              _buildAddToCartButton(context, product, lang),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(AppLocalizations? lang, dynamic product) {
    return Row(
      children: [
        Text(
          "${lang!.currency} ${product.priceAfterDiscount}",
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
            decoration: TextDecoration.lineThrough,
            decorationColor: ColorManager.gray,
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
    );
  }

  Widget _buildAddToCartButton(BuildContext context, dynamic product, AppLocalizations? lang) {
    return BlocProvider(
      create: (_) => AddToCartCubit(),
      child: BlocListener<AddToCartCubit, AddToCartState>(
        listener: (context, state) {
          switch (state) {
            case AddToCartLoadingState():
              DialogUtils.showLoading(context, lang!.login);
            case AddToCartSuccessState():
              DialogUtils.hideLoading(context);
              DialogUtils.showSuccess(
                  context,
                  "✅ Product has been added to cart");
            case AddToCartErrorState():
              DialogUtils.hideLoading(context);
              DialogUtils.showError(context, state.massage);
            default:
              break;
          }
        },
        child: Builder(
          builder: (innerContext) {

            return GestureDetector(
              onTap: () {
                final productId = product.id ?? '';
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
                      lang!.addToCart,
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
    );
  }
}