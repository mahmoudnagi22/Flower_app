import 'package:flower_app/features/app_sections/home/screen/cubit/home_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/view/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/l10n/app_localizations.dart';
import '../profile/presentation/views/profile_view.dart';
import 'categories/presentation/pages/categories_screen.dart';
import 'home/screen/home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedItem = 0;

  final List<Widget> _pages = [
    BlocProvider(create: (context) => HomeTabCubit(), child: HomeScreen()),
    CategoriesScreen(),
    Cart(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      body: _pages[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.pink,
        currentIndex: _selectedItem,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: lang!.home,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shapes),
            label: lang.categories,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: lang.cart,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: lang.profile,
          ),
        ],
      ),
    );
  }
}

//for testing
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Home Screen",
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Category Screen",
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Cart Screen",
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}
