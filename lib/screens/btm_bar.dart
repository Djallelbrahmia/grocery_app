import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/categories.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/user.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import 'cart/cart_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {"page": HomeScreen(), 'title': "Homme Screen"},
    {"page": CategoriesScreen(), 'title': "Categories  Screen"},
    {"page": CartScreen(), 'title': "Cart Screen"},
    {"page": const UserScreen(), 'title': "User  Screen"}
  ];
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context);
    bool _isdark = themeData.getDarkTheme;

    return Scaffold(
      body: _pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          backgroundColor: _isdark ? const Color(0xff151515) : Colors.white,
          showUnselectedLabels: false,
          unselectedItemColor: _isdark ? Colors.white12 : Colors.black12,
          selectedItemColor: _isdark ? Colors.white70 : Colors.black54,
          currentIndex: _selectedIndex,
          onTap: _selectPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? const Icon(IconlyBold.home)
                    : const Icon(IconlyLight.home),
                label: "Home"),
            BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? const Icon(IconlyBold.category)
                    : const Icon(IconlyLight.category),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? const Icon(IconlyBold.buy)
                    : const Icon(IconlyLight.buy),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? const Icon(IconlyBold.user2)
                    : const Icon(IconlyLight.user2),
                label: 'User')
          ]),
    );
  }
}
