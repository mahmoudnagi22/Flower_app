import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/app_sections/search/presentation/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/search_screen_content.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<SearchCubit>(),
      child: const SearchScreenContent(),
    );
  }
}


