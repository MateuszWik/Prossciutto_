import 'package:flutter/material.dart';
import 'package:mateusz/login.dart';
import 'package:mateusz/main.dart';
import 'package:mateusz/favorites.dart';
import 'package:mateusz/cart.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Testowa",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF3ECE4)),

      ),
      home: Account(),
    );
  }
}

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}
class _Account extends State<Account>{
  var selectedIndex = 0;

  final List<Widget> pages = [
    Menu(),
    Favorites(),
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: pages[selectedIndex],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                elevation: 10,
                child: Container(
                  height: 60,
                  color: Color(0xFF0C8C75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home, Icons.home_outlined, 0),
                      _buildNavItem(Icons.favorite, Icons.favorite_border_outlined, 1),
                      _buildNavItem(Icons.shopping_cart, Icons.shopping_cart_outlined, 2),
                      _buildNavItem(Icons.person_2, Icons.person_2_outlined, 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData selectedIcon, IconData unselectedIcon, int index) {
    return IconButton(
      icon: Icon(selectedIndex == index ? selectedIcon : unselectedIcon),
      color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
    );
  }
}