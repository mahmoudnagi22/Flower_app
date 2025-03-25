import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/app_sections/Screen/bottom_navigation_screen.dart';
import 'package:flower_app/features/forget_password/presentation/views/forgot_password_view.dart';
import 'package:flower_app/features/forget_password/presentation/views/reset_password_screen.dart';
import 'package:flower_app/features/login/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import '../../features/auth/signUp/presentation/pages/signup_screen.dart';


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const Login());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
        case Routes.bottomNav:
        return MaterialPageRoute(builder: (_) =>  const BottomNavigationScreen());
        case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) =>   ForgotPasswordScreen());
        case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) =>   ResetPasswordScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
