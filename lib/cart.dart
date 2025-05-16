import 'package:flutter/material.dart';
import 'miniatures.dart'; // import modelu FoodItem
class CartItem {
  final FoodItem food;
  int quantity;
  CartItem({required this.food, required this.quantity});
}
// Globalna lista koszyka
List<CartItem> cartItems = [];
class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      double unitPrice = double.tryParse(item.food.price.replaceAll('\$', '')) ?? 0.0;
      total += unitPrice * item.quantity;
    }
    return total;
  }
  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: const Center(child: Text('Your cart is empty')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFFF3ECE4),
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF3ECE4),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          double unitPrice = double.tryParse(cartItem.food.price.replaceAll('\$', '')) ?? 0.0;
          double itemTotal = unitPrice * cartItem.quantity;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0C8C75),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(cartItem.food.imagePath, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(
                cartItem.food.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Quantity: ${cartItem.quantity}\nPrice: \$${itemTotal.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (cartItem.quantity > 1) {
                          cartItem.quantity--;
                        } else {
                          cartItems.removeAt(index);
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        cartItem.quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFFF1ECE3),
        child: Text(
          'Total: \$${getTotalPrice().toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}