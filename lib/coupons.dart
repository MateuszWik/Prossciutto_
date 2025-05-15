import 'package:flutter/material.dart';
import './favorites.dart';
import './main.dart';
import './account.dart';
import './cart.dart';

void main() => runApp(CouponsApp());

class CouponsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Coupons(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Coupons extends StatefulWidget {
  @override
  State<Coupons> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<Coupons> {
  final Color mainGreen = Color(0xFF008065);
  int selectedIndex = 0;

  Widget buildCoupon(String title, String discount, {String? subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
              Icon(Icons.add, size: 20),
            ],
          ),
          SizedBox(height: 6),
          Text(discount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainGreen)),
          if (subtitle != null)
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget buildCouponsBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF0C8C75),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Permanent discounts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Weekly discounts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      buildCoupon("Student discount", "30% OFF", subtitle: "Below 25y old"),
                      buildCoupon("2nd pizza", "50% OFF"),
                      buildCoupon("User discount", "5% OFF"),
                      buildCoupon("All pasta", "2% OFF"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getPageByIndex(int index) {
    if (index == 0) return Menu();
    if (index == 1) return Favorites();
    if (index == 2) return Cart();
    if (index == 3) return Account();
    return Center(child: Text("Unknown page"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: Stack(
        children: [
          Positioned.fill(
            child: getPageByIndex(selectedIndex),
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
                      IconButton(
                        icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                        color: Colors.white,
                        onPressed: () => setState(() => selectedIndex = 0),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined),
                        color: Colors.white,
                        onPressed: () => setState(() => selectedIndex = 1),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                        color: Colors.white,
                        onPressed: () => setState(() => selectedIndex = 2),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 3 ? Icons.person : Icons.person_outline),
                        color: Colors.white,
                        onPressed: () => setState(() => selectedIndex = 3),
                      ),
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
}
