import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/utils/dialog_utils.dart';
import '../../../../../../core/utils/status.dart';
import '../cubit/occasion_cubit.dart';

class OccasionItem extends StatelessWidget {
  const OccasionItem({super.key, required this.state});

  final OccasionState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionCubit, OccasionState>(
      builder: (context, state) {
        if (state.occasionByIdState == Status.loading) {
          return const Center(child: CircularProgressIndicator(color: ColorManager.appColor));
        } else if (state.occasionByIdState == Status.error) {
          return const Center(child: Text("⚠️ Error loading occasion details"));
        } else if (state.occasionByIdState == Status.success) {
          final occasion = state.occasionById?.occasion;

          if (occasion != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    occasion.name ?? "No name available",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.network(
                    occasion.image ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No occasion selected"));
          }
        }
        return const SizedBox();
      },
    );
  }
}



