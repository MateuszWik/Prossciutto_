import 'package:flutter/material.dart';
import './account.dart';
import './cart.dart';
import './favorites.dart';
import './main.dart';

class Coupons extends StatefulWidget {
  const Coupons({super.key});

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  int selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Menu();
        break;
      case 1:
        page = Favorites();
        break;
      case 2:
        page = Cart();
        break;
      case 3:
        page = Account();
        break;
      case 4:
        page = _buildCouponsPage();
        break;
      default:
        page = Menu();
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: colorScheme.surfaceContainerHighest,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: page,
              ),
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
                  color: Color(0xFFF3ECE4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                        color: Color(0xFF004D40),
                        onPressed: () => setState(() => selectedIndex = 0),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined),
                        color: Color(0xFF004D40),
                        onPressed: () => setState(() => selectedIndex = 1),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                        color: Color(0xFF004D40),
                        onPressed: () => setState(() => selectedIndex = 2),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 3 ? Icons.person : Icons.person_outline),
                        color: Color(0xFF004D40),
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

  Widget _buildCouponsPage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Coupons',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildCouponCard(
                title: '10% Off',
                description: 'Use code SAVE10 for 10% off your order.',
              ),
              SizedBox(height: 12),
              _buildCouponCard(
                title: 'Free Delivery',
                description: 'Orders over \$50 get free delivery.',
              ),
              SizedBox(height: 12),
              _buildCouponCard(
                title: 'BOGO Pizza',
                description: 'Buy one pizza, get one free.',
              ),
              SizedBox(height: 12),
              _buildCouponCard(
                title: 'Student Special',
                description: '15% off with a valid student ID.',
              ),
              SizedBox(height: 12),
              _buildCouponCard(
                title: 'Weekend Deal',
                description: '20% off orders placed on Sat & Sun.',
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCouponCard({required String title, required String description}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0C8C75),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
