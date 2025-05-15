import 'package:flutter/material.dart';
import 'main.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SpaghettiScreen(),
  ));
}
class SpaghettiScreen extends StatefulWidget {
  @override
  _SpaghettiScreenState createState() => _SpaghettiScreenState();
}
class _SpaghettiScreenState extends State<SpaghettiScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1ECE3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Menu()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Spaghetti Sicily',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '25\$',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/Spaghetti-Sicily.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF0C8C75),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Pasta ala Sicilia is a traditional Sicilian dish consisting of pasta, usually penne or spaghetti, served with an aromatic sauce made from a mixture of spices alla Siciliana, dried tomatoes, garlic, olive oil, onion, eggplants and fresh basil.',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                              ),
                              Text('$quantity'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF1ECE3),
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Add to'),
                                SizedBox(width: 8),
                                Icon(Icons.shopping_cart_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









