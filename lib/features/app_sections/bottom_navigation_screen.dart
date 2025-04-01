import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationScreen extends StatefulWidget {
   const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedItem  =0;

  final List<Widget> _pages = const[
    Home(),
    Category(),
    Cart(),
    Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedItem  =index;
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: _pages[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.pink,
        currentIndex: _selectedItem ,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
            label: 'Home',),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.shapes),
            label: 'Category',),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',),
            BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),
            label: 'Profile',),

          ]
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

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}