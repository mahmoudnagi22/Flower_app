import 'package:flower_app/core/routes_manager/route_generator.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cubits/local_cubit/local_cubit.dart';
import 'core/di/di.dart';
import 'core/l10n/app_localizations.dart';

import 'features/auth/change_password/data/api_call/api_call.dart';
import 'features/localization/domain/use_cases/get_language.dart';
import 'features/localization/domain/use_cases/set_language.dart';

import 'features/auth/login/presentation/cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadSavedUserToken();

  configureDependencies();

  runApp(const FlowerApp());
}

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Localization
        BlocProvider(
          create: (context) => LocalizationCubit(
            getIt<GetLanguageUseCase>(),
            getIt<SetLanguageUseCase>(),
          ),
        ),

        // LoginCubit
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),

        // AddToCartCubit
        BlocProvider(
          create: (context) => getIt<AddToCartCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LocalizationCubit, Localization>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(state.language),
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.loginRoute,
                onGenerateRoute: RouteGenerator.getRoute,
              );
            },
          );
        },
      ),
    );
  }
}
