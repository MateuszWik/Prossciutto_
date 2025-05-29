import 'package:flutter/material.dart';
import 'package:mateusz/cart_data.dart';
import 'package:mateusz/coupons_data.dart';
import 'package:mateusz/order.dart';

class Cart extends StatefulWidget {
  final String? dateOfBirth;

  const Cart({super.key, this.dateOfBirth});

  @override
  State<Cart> createState() => _CartState();
}

class FoodItem {
  final String title;
  final String price;
  final String imagePath;
  final String description;

  FoodItem({
    required this.title,
    required this.price,
    required this.imagePath,
    required this.description,
  });
}

class _CartState extends State<Cart> {

  int? calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) return null;

    try {
      final birthDate = DateTime.parse(dateOfBirth);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double calculateTotal() {
      double total = 0.0;
      double totalDiscountAmount = 0.0;
      int totalDiscount = 0;

      for (final item in cartItems) {
        final title = item.foodItem.title.toLowerCase();
        final quantity = item.quantity;

        double itemTotal;

        if (title == 'water') {
          itemTotal = 0;
          for (int i = 2; i <= quantity; i++) {
            itemTotal += 1;
          }
        } else if (title == 'bread sticks') {
          itemTotal = 0;
          for (int i = 2; i <= quantity; i++) {
            itemTotal += 1.99;
          }
        } else {
          final unitPrice = double.tryParse(item.foodItem.price.replaceAll('\$', '')) ?? 0.0;
          itemTotal = unitPrice * quantity;
        }

        total += itemTotal;
      }

      for (final coupon in CouponData.appliedCoupons) {
        for (final item in cartItems) {
          final title = item.foodItem.title.toLowerCase();
          final quantity = item.quantity;
          final discount = coupon.discount;
          final unitPrice = double.tryParse(item.foodItem.price.replaceAll('\$', '')) ?? 0.0;

          switch (coupon.title.toLowerCase()) {
            case "student's":
              final age = calculateAge(widget.dateOfBirth);
              if (age != null && age >= 19 && age <= 25) {
                totalDiscount += discount;
              }
              break;

            case 'user discount':
              totalDiscount += discount;
              break;

            case 'all pasta':
              if (title == 'macaroni' || title == 'spaghetti sicily' || title == 'penne all\' arrabbiata') {
                totalDiscount += discount;
              }
              break;

            case '2nd same pizza':
              if (quantity >= 2 && title.contains('pizza')) {
                int numberOfDiscounted = quantity ~/ 2;
                double discountAmount = numberOfDiscounted * unitPrice * (discount / 100);
                totalDiscountAmount += discountAmount;
              }
              break;
          }
        }
      }

      if (totalDiscount > 0) {
        total *= (1 - totalDiscount / 100);
      }
      total -= totalDiscountAmount;

      return total;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Cart',
                  style: TextStyle(
                    fontFamily: 'LeagueSpartan',
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            if (cartItems.isNotEmpty) ...[
              Positioned(
                left: 15,
                top: MediaQuery.of(context).size.height * 0.12,
                right: 25,
                bottom: MediaQuery.of(context).size.height * 0.15,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          final price = item.foodItem.price;
                          final title = item.foodItem.title;
                          final quantity = item.quantity;
                          final imagePath = item.foodItem.imagePath;

                          double totalItemPrice;
                          if (title.toLowerCase() == 'water' || title.toLowerCase() == 'bread sticks') {
                            totalItemPrice = 0;
                            if (title.toLowerCase() == 'water') {
                              for (int i = 2; i <= quantity; i++) {
                                totalItemPrice += 1;
                              }
                            } else if (title.toLowerCase() == 'bread sticks') {
                              for (int i = 2; i <= quantity; i++) {
                                totalItemPrice += 1.99;
                              }
                            }
                          } else {
                            final unitPrice = double.tryParse(price.replaceAll('\$', '')) ?? 0.0;
                            totalItemPrice = unitPrice * quantity;
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.2),
                            child: Row(
                              // Blok produktu
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFF0C8C75),
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  height: 68,
                                  width: MediaQuery.of(context).size.width * 0.56,
                                  padding: EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$title',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontFamily: 'MontSerrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\n\$${totalItemPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'MontSerrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 6.4),
                                Container(
                                  // blok -1+
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * 0.31,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF0C8C75),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        iconSize: MediaQuery.of(context).size.width * 0.04,
                                        tooltip: 'Remove',
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            if (item.quantity > 1) {
                                              item.quantity--;
                                            } else {
                                              cartItems.removeAt(index);
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        '$quantity',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                          fontFamily: 'MontSerrat',
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        iconSize: MediaQuery.of(context).size.width * 0.04,
                                        tooltip: 'Add',
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            item.quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Divider(
                        // linia pozioma
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        // total i kupony
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${calculateTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontFamily: 'LeagueSpartan',
                              fontSize: 16,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Used coupons: ${CouponData.appliedCoupons.map((c) => c.title).join(', \n')}',
                              style: TextStyle(
                                fontFamily: 'LeagueSpartan',
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // blok Next
                top: MediaQuery.of(context).size.height * 0.68,
                left: 5,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Order())
                  );},
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.91,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF0C8C75),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'LeagueSpartan',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Cart is empty',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
