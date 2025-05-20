import 'package:flutter/material.dart';
import './main.dart';
import './cart.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Menu(),
  ));
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

final List<FoodItem> foodItems = [
  FoodItem(
    title: 'Macaroni',
    price: '20\$',
    imagePath: 'assets/images/Macaroni.png',
    description: '\nDelicious macaroni from Campania region, with rich tomato sauce and herbs.',
  ),
  FoodItem(
    title: 'Spaghetti Sicily',
    price: '25\$',
    imagePath: 'assets/images/Spaghetti-Sicily.png',
    description: '\nTraditional Sicilian pasta with rich tomato-based sauce and fresh ingredients.',
  ),
  FoodItem(
    title: 'Penne all\' Arrabbiata',
    price: '25\$',
    imagePath: 'assets/images/Penne_all_arrabbiata.png',
    description: '\nSpicy penne pasta with garlic, tomatoes and red chili peppers.',
  ),
  FoodItem(
    title: 'Pizza Margherita',
    price: '15\$',
    imagePath: 'assets/images/Margherita.png',
    description: '\nClassic pizza with fresh tomatoes, mozzarella cheese and basil.',
  ),
  FoodItem(
    title: 'Pizza Prosciutto e Funghi',
    price: '25\$',
    imagePath: 'assets/images/Prosciutto_e_funghi.png',
    description: '\n topped with ham and mushrooms.',
  ),
  FoodItem(
    title: 'Pizza Quattro Formaggi',
    price: '25\$',
    imagePath: 'assets/images/Quattro_Formaggi.png',
    description: '\nFour cheese pizza with mozzarella, gorgonzola, parmesan and ricotta.',
  ),
  FoodItem(
    title: 'Frantonio Oil',
    price: '3\$',
    imagePath: 'assets/images/Frantoio-Oil.png',
    description: '\nHigh quality olive oil from Frantoio olives.',
  ),
  FoodItem(
    title: 'Leccino Oil',
    price: '4\$',
    imagePath: 'assets/images/Leccino-Oil.png',
    description: '\nPremium olive oil made from Leccino olives.',
  ),
  FoodItem(
    title: 'Water',
    price: 'Free of Charge',
    imagePath: 'assets/images/Water.png',
    description: '\nFresh and pure mineral water.',
  ),
  FoodItem(
    title: 'Bread Sticks',
    price: 'Free of Charge',
    imagePath: 'assets/images/bread_sticks.png',
    description: 'Crunchy and tasty bread sticks perfect as a side.',
  ),
];

class FoodDetailScreen extends StatefulWidget {
  final int selectedIndex;

  const FoodDetailScreen({super.key, required this.selectedIndex});

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;

  String calculateTotalPrice(FoodItem food, int quantity) {
    if (food.title == 'Water') {
      if (quantity <= 1) {
        return 'Free of Charge';
      } else {
        double total = (quantity - 1) * 1.0;
        return '\$${total.toStringAsFixed(2)}';
      }
    } else if (food.title == 'Bread Sticks') {
      if (quantity <= 1) {
        return 'Free of Charge';
      } else {
        double total = (quantity - 1) * 1.99;
        return '\$${total.toStringAsFixed(2)}';
      }
    } else {
      double unitPrice = double.tryParse(food.price.replaceAll('\$', '')) ??
          0.0;
      double total = unitPrice * quantity;
      return '\$${total.toStringAsFixed(2)}';
    }
  }
  @override
  Widget build(BuildContext context) {
    final food = foodItems[widget.selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF3ECE4),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.27,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0C8C75),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      food.description,
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'MontSerrat',
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
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
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                              ),
                              Text('$quantity'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Cart()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF1ECE3),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Menu()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'LeagueSpartan',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food.price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'LeagueSpartan',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        food.imagePath,
                        height: 250,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}