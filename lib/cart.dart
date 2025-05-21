
import 'package:flutter/material.dart';
import './miniatures.dart';

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
class _CartState extends State<Cart> {
  int number = 1;
  int value = 20;
  double equal = 0;

  void total() {
    setState(() {
      equal = number * value.toDouble();
    });
  }

  @override
  void initState() {
    super.initState();
    total();
  }

  @override
  Widget build(BuildContext context) {

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFF0C8C75),
                            image: DecorationImage(
                              image: AssetImage('assets/images/Macaroni.png'),
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
                                'Macaroni \n Campania',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'MontSerrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\n$value\$',
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
                                    if (number > 0) number--;
                                    total();
                                  });
                                },
                              ),
                              Text(
                                '$number',
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
                                    number++;
                                    total();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          'Total: $equal\$',
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
