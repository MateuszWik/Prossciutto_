import 'package:flutter/material.dart';

import 'main.dart';

// Pamiętaj, aby zaimportować swoją klasę Menu, np.:
// import 'menu.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF3ECE4)),
        useMaterial3: true,
      ),
      home: Coupons(),
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
  final Color mainWhite = const Color(0xFFF3ECE4);

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 4:
        page = _buildCouponsPage();
        break;
      default:
        page = Center(child: Text("Placeholder Page"));
    }

    return Scaffold(
      backgroundColor: mainWhite,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: page,
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
                  color: mainWhite,
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
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Menu()),
                      );
                    },
                    child: Image.asset("assets/images/left_arrow.png", width: 24, height: 24),
                  ),
                ),
                const Center(
                  child: Text(
                    "Coupons",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: mainGreen,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = 2;
                  double spacing = 15;
                  double totalSpacing = spacing * (crossAxisCount - 1);
                  double itemWidth = (width - totalSpacing) / crossAxisCount;
                  double itemHeight = itemWidth * 0.75;

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: itemWidth / itemHeight,
                    children: [
                      _buildCouponCard(
                        title: 'Student discount',
                        description: '30% OFF\nBelow 25y old',
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({required String title, required String description}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
            decoration: BoxDecoration(
              color: mainWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'League Spartan',
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 8,
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}