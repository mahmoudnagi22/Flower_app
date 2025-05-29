import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/features/app_sections/cart/presentation/pages/cart_screen.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_cubit.dart';
import 'package:flower_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'categories/presentation/pages/categories_screen.dart';
import 'home/screen/home_screen.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_status.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedItem = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BlocProvider(
        create: (context) => HomeTabCubit(),
        child: const HomeScreen(),
      ),
      const CategoriesScreen(),
      const CartScreen(),
      const Profile(),
    ];
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      final authState = context.read<LoginCubit>().state;

      if (authState is LoginSuccessState) {
        setState(() {
          _selectedItem = index;
        });
      } else {
        DialogUtils.showMessage(
          context,
          'Please log in to access the cart.',
          Icon: (icon) { Icon(Icons.login, color: ColorManager.appColor); },
          posActionName: 'Login',
          posAction: () =>  Navigator.pushNamed(
            context,
            Routes.loginRoute,

          ),

        );
      }
    } else {
      setState(() {
        _selectedItem = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);

    return Scaffold(
      body: _selectedItem == 2
          ? const CartScreen()
          : IndexedStack(
        index: _selectedItem > 2 ? _selectedItem - 1 : _selectedItem,
        children: [
          _pages[0], // Home
          _pages[1], // Categories
          _pages[3], // Profile (skip Cart)
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ColorManager.white,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.pink,
          currentIndex: _selectedItem,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: lang!.home,
            ),
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.shapes),
              label: lang.categories,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              label: lang.cart,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_2_outlined),
              label: lang.profile,
            ),
          ],
        ),
      ),
    );
  }
}
