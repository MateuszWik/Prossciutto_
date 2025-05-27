import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Thank You for your order!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
            fontFamily: 'LeagueSpartan'),
        ),
      ),
    );
  }
}
