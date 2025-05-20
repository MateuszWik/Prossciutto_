import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int number = 1;
  int value = 20;
  String coupon = 'none';
  double equal = 0;

  void saveNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('number', number);
  }

  void loadNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      number = prefs.getInt('number') ?? 1;
    });
  }

  void total() async {
    setState(() {
      equal = number * value.toDouble();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('equal', equal);
  }

  void loadTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      equal = prefs.getDouble('equal') ?? 0.0;
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
    return SafeArea(

      child: Stack(
        children: [
          // Napis gorny Cart
          AppBar(
            centerTitle: true,
            title: Text(
              'Cart',
              style: TextStyle(
                fontFamily: 'LeagueSpartan',
                fontSize: 25,
              ),
            ),
          ),
          // Tylko pokaż, jeśli ilosc > 0
          if (number > 0)...[
            Positioned(
              left: 15,
              top: 130,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Blok: produkt
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

                      SizedBox(width: 10-3.6,),

                      // Blok: - 1 +
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
                              onPressed: () {
                                setState(() {
                                  if (number > 0) {
                                    number--;
                                    total();
                                    saveNumber();
                                  }
                                });
                              },
                            ),
                            Text(
                              '$number',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontFamily: 'MontSerrat',
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              iconSize: MediaQuery.of(context).size.width * 0.04,
                              tooltip: 'Dodaj',
                              onPressed: () {
                                setState(() {
                                  number++;
                                  total();
                                  saveNumber();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total: $equal',
                          style: TextStyle(
                            fontFamily: 'Leauge Spartan',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Used coupons: $coupon',
                          style: TextStyle(
                            fontFamily: 'Leauge Spartan',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
              height: 200,
                width: 200,
                color: Color(0xFF0C8C75),
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
                    fontFamily: 'Leauge Spartan',
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ]
        ],
      ),
    );
  }

}

