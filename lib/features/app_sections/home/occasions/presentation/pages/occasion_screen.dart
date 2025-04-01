import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/features/app_sections/home/occasions/presentation/cubit/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/utils/status.dart';
import '../widgets/occasion_item.dart';

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
        create: (context) =>  getIt<OccasionCubit>()..getOccasions(),
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
                    10.verticalSpace,
                    OccasionItem(state: state),

                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
