// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mira_store_app/models/category.dart';
import 'package:mira_store_app/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:mira_store_app/views/screens/nav_screens/account_screen.dart';
import 'package:mira_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:mira_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:mira_store_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:mira_store_app/views/screens/nav_screens/store_screen.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  const InnerCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    int _pageIndex = 0;

    final List<Widget> _pages = [
      InnerCategoryContentWidget(
        category: widget.category,
      ),
      const FavoriteScreen(),
      const CategoryScreen(),
      const StoreScreen(),
      const CartScreen(),
       AccountScreen(),
    ];

    return Scaffold(
     
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 25,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/love.png',
                width: 25,
              ),
              label: "Favorite"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/mart.png',
              width: 25,
            ),
            label: "Store",
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/cart.png',
                width: 25,
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/user.png',
                width: 25,
              ),
              label: "Account"),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
