import 'package:flutter/material.dart';
import 'main.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3ece4),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thank You for your order!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'LeagueSpartan',
              ),
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Back to Home Screen",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
