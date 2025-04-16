import 'package:flower_app/core/routes_manager/route_generator.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/di.dart';
import 'features/auth/login/presentation/cubit/login_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AppBlocObserver();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,

        builder:
            (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: child,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.loginRoute,
            ),
      ),
    );
  }
}

//flutter packages pub run build_runner watch
//flutter packages pub run build_runner build
