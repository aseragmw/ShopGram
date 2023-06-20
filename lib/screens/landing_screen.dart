import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:db_shop/screens/cart_screen.dart';
import 'package:db_shop/screens/home_screen.dart';
import 'package:db_shop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: _currentPage == 0
            ? HomeScreen()
            : _currentPage == 1
                ? CartScreen()
                : ProfileScreen(),
        bottomNavigationBar: CurvedNavigationBar(
            height: 70,
            backgroundColor: Colors.transparent,
            color: Color.fromARGB(255, 14, 32, 199),
            onTap: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            items: [
              const Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.white,
              ),
              const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ]));
  }
}
