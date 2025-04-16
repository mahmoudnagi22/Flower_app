import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/app_sections/bottom_navigation_screen.dart';
import 'package:flower_app/features/app_sections/home/occasions/presentation/pages/occasion_screen.dart';
import 'package:flower_app/features/auth/login/presentation/screens/login.dart';
import 'package:flower_app/features/best_seller.dart';
import 'package:flower_app/features/edit_profile/presentation/view/edit_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../features/app_sections/home/categories/presentation/pages/categories_screen.dart';
import '../../features/auth/signUp/presentation/pages/signup_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const Login());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.bottomNav:
        return MaterialPageRoute(
          builder: (_) => const BottomNavigationScreen(),
        );
      case Routes.occasions:
        return MaterialPageRoute(builder: (_) => OccasionScreen());
      case Routes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case Routes.best:
        return MaterialPageRoute(builder: (_) => const BestSeller());
      case Routes.editProfileRoute:
        return MaterialPageRoute(builder: (context) => EditProfileScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('No Route Found')),
            body: const Center(child: Text('No Route Found')),
          ),
    );
  }
}
