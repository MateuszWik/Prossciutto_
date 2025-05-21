import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mateusz/cart_data.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}
class Coupon {
  final String title;
  final String description;

  Coupon({
    required this.title,
    required this.description,
  });
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
  int number = 1;
  int value = 20;
  double equal = 0;

  void saveNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('number', number);
  }

  void loadNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      number = prefs.getInt('ilosc') ?? 1;
    });
  }

  void total() async {
    setState(() {
      equal = number * value.toDouble();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('wynik', equal);
  }

  void loadTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      equal = prefs.getDouble('wynik') ?? 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    loadNumber();
    loadTotal();
  }


  @override
  Widget build(BuildContext context) {
    double calculateTotal() {
      double total = 0.0;
      for (final item in cartItems) {
        final unitPrice = double.tryParse(item.foodItem.price.replaceAll('\$', '')) ?? 0.0;
        total += unitPrice * item.quantity;
      }
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
            if (number > 0) ...[
              Positioned(
                left: 15,
                top: MediaQuery.of(context).size.height * 0.12,
                right: 25,
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

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
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
                                height: 85,
                                width: MediaQuery.of(context).size.width * 0.56,
                                padding: EdgeInsets.all(7.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$title x$quantity',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontFamily: 'MontSerrat',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\n$price',
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
                                      tooltip: 'Usuń',
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
                                      tooltip: 'Dodaj',
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
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.37),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${calculateTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: 'LeagueSpartan',
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Used coupon:none',
                          style: TextStyle(
                            fontFamily: 'LeagueSpartan',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.68,
                left: 5,
                child: TextButton(
                  onPressed: () {},
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
            ]
            else if(number <= 0)...[
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
