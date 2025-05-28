import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/core/widget/custom_card.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/occasions/presentation/cubit/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/status.dart';

class OccasionScreen extends StatelessWidget {
  OccasionScreen({super.key});

  final OccasionCubit viewModel = getIt.get<OccasionCubit>();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                DialogUtils.showError(context, state.occasionError ?? '');
              });
              return const SizedBox();
            } else if (state.occasionState == Status.success) {
              return DefaultTabController(
                length: state.occasionList?.length ?? 0,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: ColorManager.appColor,
                        dividerColor: Colors.transparent,
                        labelColor: ColorManager.appColor,
                        unselectedLabelColor: ColorManager.gray,
                        tabAlignment: TabAlignment.center,
                        onTap: (index) {
                          final selectedOccasion = state.occasionList?[index].id;
                          context.read<OccasionCubit>().getProducts(
                            ProductFilter(occasionId: selectedOccasion),
                          );
                        },
                        tabs: state.occasionList?.map((occasion) {
                          return Tab(text: occasion.name ?? '');
                        }).toList() ??
                            [],
                      ),
                      10.verticalSpace,


                      if (state.productsState == Status.loading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              color: ColorManager.appColor,
                            ),
                          ),
                        ),


                      if (state.productsState == Status.success)
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.productDetails,
                                    arguments: product,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
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
