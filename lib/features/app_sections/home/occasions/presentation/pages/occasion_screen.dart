import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/features/app_sections/home/occasions/presentation/cubit/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        create: (context) =>
        getIt<OccasionCubit>()
          ..getOccasions(),
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
                          if (selectedOccasion != null &&
                              selectedOccasion.id != null) {
                            context.read<OccasionCubit>().getOccasionById(
                              selectedOccasion.id!,
                            );
                          }
                        },
                        tabs:
                        state.occasionList?.map((occasion) {
                          return Tab(text: occasion.name ?? '');
                        }).toList() ??
                            [],
                      ),
                    ),
                    30.verticalSpace,
                    if (state.occasionByIdState == Status.loading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.appColor,
                        ),
                      ),
                    if (state.occasionByIdState == Status.success) ...[
                      Text(
                        state.occasionById?.occasion?.name ??
                            "No name available",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.verticalSpace,
                      Image.network(
                        state.occasionById?.occasion?.image ?? '',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
