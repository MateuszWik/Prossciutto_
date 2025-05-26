import 'package:flutter/material.dart';
import 'main.dart';
import 'package:mateusz/coupons_data.dart';
class Coupons extends StatefulWidget {
  final int? userAge;
const Coupons({super.key, this.userAge});

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
                      {'title': '2nd same pizza', 'description': '50% OFF\nCannot be combined with other coupons','discount': '50'},
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
                  bottom: 36,
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
                      final conditionalCoupons = ['Student\'s', 'User discount'];
                      final exclusiveCoupon = '2nd same pizza';

                      bool isExclusive = title == exclusiveCoupon;
                      bool isConditional = conditionalCoupons.contains(title);

                      bool hasExclusive = CouponData.appliedCoupons.any((c) => c.title == exclusiveCoupon);
                      bool hasConditional = CouponData.appliedCoupons.any((c) => conditionalCoupons.contains(c.title));

                      bool isStudentCoupon = title == "Student's";
                      bool isUserDiscount = title == "User discount";
                      bool validStudentAge = widget.userAge != null && widget.userAge! >= 19 && widget.userAge! <= 25;
                      bool isLoggedIn = widget.userAge != null && widget.userAge! > 0;

                      setState(() {
                        if (isApplied) {
                          CouponData.removeCoupon(coupon);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed coupon: ${coupon.title}', style: TextStyle(color: Colors.black)),
                              duration: Duration(seconds: 2),
                              backgroundColor: mainWhite,
                            ),
                          );
                        } else if (isStudentCoupon && !validStudentAge) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Student coupon valid only for age 19-25'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else if (isUserDiscount && !isLoggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('User discount is only available when logged in.'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else if ((isExclusive && hasConditional) || (isConditional && hasExclusive)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Cannot combine "$title" with current discount.',
                                style: TextStyle(color: Colors.black),
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.orange.shade200,
                            ),
                          );
                        } else {
                          CouponData.applyCoupon(coupon);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Applied coupon: ${coupon.title}', style: TextStyle(color: Colors.black)),
                              duration: Duration(seconds: 2),
                              backgroundColor: mainWhite,
                            ),
                          );
                        }
                      });
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