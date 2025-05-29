import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_cubit.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_states.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/app_bar_search.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/best_seller_item.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/categories_item.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/location.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/occasion_item.dart';
import 'package:flower_app/features/app_sections/home/screen/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeTabCubit>().getHomeData();
  }

  ProductEntity productToEntity(dynamic product) {
    return ProductEntity(
      id: product.id,
      title: product.title,
      slug: product.slug,
      description: product.description,
      imgCover: product.imgCover,
      images: product.images,
      price: product.price,
      priceAfterDiscount: product.priceAfterDiscount,
      quantity: product.quantity,
      category: product.category,
      occasion: product.occasion,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
      v: product.v,
      discount: product.discount,
      sold: product.sold,
      rateAvg: product.rateAvg,
      rateCount: product.rateCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return BlocBuilder<HomeTabCubit, HomeStates>(
      builder: (context, state) {
        if (state is HomeLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.appColor),
          );
        }
        if (state is HomeSuccessStates) {
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: Padding(
              padding: REdgeInsets.only(top: 40.0, left: 25.w, right: 25.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AppBarSearch(),
                    const Location(),
                    TitleOfGroup(
                      nameOfGroup: lang!.categories,
                      routesNamed: Routes.categories,
                    ),
                    SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoriesItem(
                            category: state.categories[index],
                          );
                        },
                      ),
                    ),
                    TitleOfGroup(
                      nameOfGroup: lang.bestSeller,
                      routesNamed: Routes.bestSellerScreen,
                    ),
                    SizedBox(
                      height: 195.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.bestSeller.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.productDetails,
                              arguments: productToEntity(state.bestSeller[index]),
                            ),
                            child: BestSellerItem(
                              bestSeller: state.bestSeller[index],
                            ),
                          );
                        },
                      ),
                    ),
                    TitleOfGroup(
                      nameOfGroup: lang.occasions,
                      routesNamed: Routes.occasions,
                    ),
                    SizedBox(
                      height: 195.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.occasions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.productDetails,
                              arguments: productToEntity(state.occasions[index]),
                            ),
                            child: OccasionItem(
                              occasions: state.occasions[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }
}
