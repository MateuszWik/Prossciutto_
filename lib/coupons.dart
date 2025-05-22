import 'package:flutter/material.dart';
import 'main.dart';
import 'package:mateusz/coupons_data.dart';
class Coupons extends StatefulWidget {
  const Coupons({super.key});

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  final Color mainGreen = const Color(0xFF0C8C75);
  final Color mainWhite = const Color(0xFFF3ECE4);

  @override
  Widget build(BuildContext context) {
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/left_arrow.png",
                        width: 24,
                      ),
                    ),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Permanent discounts",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildCouponGrid(_buildCouponCards([
                      {'title': "Student's", 'description': '30% OFF\nBelow 25y old', 'discount': '30'},
                      {'title': 'User discount', 'description': '5% OFF','discount': '5'},
                    ])),
                    const SizedBox(height: 30),
                    const Text(
                      "Weekly discounts",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildCouponGrid(_buildCouponCards([
                      {'title': '2nd same pizza', 'description': '50% OFF','discount': '50'},
                      {'title': 'All pasta', 'description': '2% OFF','discount': '2'},
                    ])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCouponCards(List<Map<String, String>> coupons) {
    return coupons.map((coupon) {
      return _buildCouponCard(
        title: coupon['title']!,
        description: coupon['description']!,
        discount: int.parse(coupon['discount']!),
      );
    }).toList();
  }

  Widget _buildCouponGrid(List<Widget> cards) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = 2;
        double spacing = 20;
        double totalSpacing = spacing * (crossAxisCount - 1);
        double itemWidth = (width - totalSpacing) / crossAxisCount;
        double itemHeight = itemWidth * 0.80/0.8;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: itemWidth / itemHeight,
          children: cards,
        );
      },
    );
  }

  Widget _buildCouponCard({required String title, required String description, required int discount}) {
    bool isApplied = CouponData.appliedCoupons.any((c) => c.title == title);

    IconData icon = isApplied ? Icons.check : Icons.add;
    String tooltip = isApplied ? 'Remove coupon' : 'Apply coupon';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
            decoration: BoxDecoration(
              color: mainWhite,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: const TextStyle(
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      icon,
                      size: 28,
                      color: Colors.black,
                    ),
                    tooltip: 'Apply coupon',
                    onPressed: () {
                        final coupon = Coupon(title: title, description: description, discount: discount);

                        setState(() {
                          if (isApplied) {
                            CouponData.removeCoupon(coupon);
                          } else {
                            CouponData.applyCoupon(coupon);
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isApplied
                                  ? 'Removed coupon: ${coupon.title}'
                                  : 'Applied coupon: ${coupon.title}',
                              style: TextStyle(color: Colors.black),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: mainWhite,
                          ),
                        );
                      },
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


