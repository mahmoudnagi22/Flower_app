import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/features/app_sections/cart/presentation/pages/cart_screen.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_cubit.dart';
import 'package:flower_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'categories/presentation/pages/categories_screen.dart';
import 'home/screen/home_screen.dart';

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
    setState(() {
      _selectedItem = index;
    });
  }

 @override
Widget build(BuildContext context) {
  var lang = AppLocalizations.of(context);

  return Scaffold(
    body: _selectedItem == 2
        ? const CartScreen() // Rebuild every time
        : IndexedStack(
            index: _selectedItem > 2 ? _selectedItem - 1 : _selectedItem,
            children: [
              _pages[0], // Home
              _pages[1], // Categories
              _pages[3], // Profile (skipping cart)
            ],
          ),
    bottomNavigationBar: BottomNavigationBar(
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
  );
}

}
