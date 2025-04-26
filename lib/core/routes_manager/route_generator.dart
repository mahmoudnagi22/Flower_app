import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/app_sections/bottom_navigation_screen.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';
import 'package:flower_app/features/app_sections/product_details/presentation/pages/product_details.dart';
import 'package:flower_app/features/app_sections/search/presentation/pages/search_screen.dart';
import 'package:flower_app/features/app_sections/search/presentation/widgets/search_screen_content.dart';

import 'package:flower_app/features/app_sections/cart/presentation/pages/cart_screen.dart';
import 'package:flower_app/features/auth/change_password/presentation/screens/change_password_screen.dart';
import 'package:flower_app/features/app_sections/terms_about_us/about_us/pages/about_us.dart';
import 'package:flower_app/features/app_sections/terms_about_us/terms_conditions.dart/terms_conditions.dart';

import 'package:flower_app/features/auth/login/presentation/screens/login.dart';
import 'package:flower_app/features/best_seller.dart';
import 'package:flower_app/features/splash/presentation/views/spalsh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/app_sections/categories/presentation/pages/categories_screen.dart';
import '../../features/app_sections/occasions/presentation/pages/occasion_screen.dart';
import '../../features/auth/login/presentation/cubit/login_cubit.dart';
import '../../features/auth/signUp/presentation/pages/signup_screen.dart';
import '../../features/splash/domain/use_cases/get_user_data.dart';
import '../../features/splash/presentation/cubits/auto_login_cubit/auto_login_cubit.dart';
import '../di/di.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => LoginCubit(),
              child: const Login(),
            ));
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
      case Routes.search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case Routes.best:
        return MaterialPageRoute(builder: (_) => const BestSeller());
      case Routes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.changepassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case Routes.splash:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) => AutoLoginCubit(getIt<GetUserDataUseCase>()),
                child: const SplashView(),
              ),
          settings: settings,
        );
        return MaterialPageRoute(builder: (_) => const BestSeller());
      case Routes.productDetails:

        return MaterialPageRoute(
          builder:
              (_) =>
                  ProductDetails(product: settings.arguments as ProductEntity),
        );

        return MaterialPageRoute(builder: (_) => ProductDetails(product: settings.arguments as ProductEntity,));
       case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => AboutUsScreen(),);
        case Routes.termsConditions:
        return MaterialPageRoute(builder: (_) => TermsAndConditionsScreen(),);

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
