import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF3ECE4)),
      ),
      home: Coupons(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Coupons extends StatefulWidget {
  const Coupons({super.key});

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  int selectedIndex = 4;
  final Color mainGreen = const Color(0xFF0C8C75);
  final Color mainwhite = const Color(0xFFF3ECE4);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Placeholder();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      case 4:
        page = _buildCouponsPage();
        break;
      default:
        page = Placeholder();
    }

    return Scaffold(
      backgroundColor: mainwhite,
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
                        color: mainGreen,
                        onPressed: () => setState(() => selectedIndex = 0),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined),
                        color: mainGreen,
                        onPressed: () => setState(() => selectedIndex = 1),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                        color: mainGreen,
                        onPressed: () => setState(() => selectedIndex = 2),
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 3 ? Icons.person : Icons.person_outline),
                        color: mainGreen,
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
      child: Column(
        children: [
          // App bar
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/images/left_arrow.png"),
                ),
                const Text(

                  "Coupons",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'League Spartan',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Body with green background
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: mainGreen,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Permanent discounts",
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Weekly discounts",
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Coupon cards
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 3 / 1.5,
                      children: [
                        _buildCouponCard(
                          title: 'Student discount',
                          description: '30% OFF • Below 25y old',
                        ),
                        _buildCouponCard(
                          title: '2nd pizza',
                          description: '50% OFF',
                        ),
                        _buildCouponCard(
                          title: 'User discount',
                          description: '5% OFF',
                        ),
                        _buildCouponCard(
                          title: 'All pasta',
                          description: '2% OFF',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({required String title, required String description}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: mainwhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: mainGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'League Spartan',
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
