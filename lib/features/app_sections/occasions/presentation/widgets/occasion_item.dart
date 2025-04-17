// import 'package:flower_app/core/resources/color_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../core/di/di.dart';
// import '../../../../../../core/utils/dialog_utils.dart';
// import '../../../../../../core/utils/status.dart';
// import '../cubit/occasion_cubit.dart';
//
// class OccasionItem extends StatelessWidget {
//   const OccasionItem({super.key, required this.state});
//
//   final OccasionState state;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OccasionCubit, OccasionState>(
//       builder: (context, state) {
//         if (state.productsState == Status.loading) {
//           return const Center(child: CircularProgressIndicator(color: ColorManager.appColor));
//         } else if (state.productsState == Status.error) {
//           return const Center(child: Text("⚠️ Error loading occasion details"));
//         } else if (state.productsState == Status.success) {
//           final occasion = state.occasionById?.occasion;
//
//           if (occasion != null) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 const SizedBox(height: 10),
//
//               ],
//             );
//           } else {
//             return const Center(child: Text("No occasion selected"));
//           }
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }



