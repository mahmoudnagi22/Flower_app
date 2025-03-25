import 'package:flower_app/core/routes_manager/route_generator.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/forget_password/domain/repositories/forgot_password_repository.dart';
import 'features/forget_password/presentation/view_model/forgot_password_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ForgotPasswordCubit(AuthRepository())),        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.forgetPassword,
        ),
      ),
    );
  }
}
