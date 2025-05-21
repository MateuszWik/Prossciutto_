import 'package:flutter/material.dart';
import 'miniatures.dart';

class Cart extends StatefulWidget {
  final CartItem? addedItem;
  const Cart({super.key, this.addedItem});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.addedItem != null) {
      addOrUpdateItem(widget.addedItem!);
    }
  }

  void addOrUpdateItem(CartItem newItem) {
    final index = cartItems.indexWhere(
            (item) => item.foodItem.title == newItem.foodItem.title);
    if (index != -1) {
      cartItems[index].quantity += newItem.quantity;
    } else {
      cartItems.add(newItem);
    }
    calculateTotal();
  }

  void calculateTotal() {
    double sum = 0.0;

    for (var item in cartItems) {
      String titleLower = item.foodItem.title.toLowerCase();

      if (titleLower.contains('water') || titleLower.contains('woda')) {
        if (item.quantity > 1) {
          sum += (item.quantity - 1) * 1.0; // Woda: 1$ od drugiej sztuki
        }
      } else if (titleLower.contains('bread stick') || titleLower.contains('bread stiks')) {
        if (item.quantity > 1) {
          sum += (item.quantity - 1) * 1.99; // Bread Sticks: 1.99$ od drugiej sztuki
        }
      } else {
        double price = double.tryParse(
            item.foodItem.price.replaceAll('\$', '').replaceAll(',', '.')) ??
            0.0;
        sum += price * item.quantity;
      }
    }

    setState(() {
      totalPrice = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C8C75),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C8C75),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'LeagueSpartan',
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.bold),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Image.asset(
                            item.foodItem.imagePath,
                            height: 80,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.foodItem.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MontSerrat',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.foodItem.price,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add,
                                  color: Colors.teal),
                              onPressed: () {
                                setState(() {
                                  item.quantity++;
                                  calculateTotal();
                                });
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.remove,
                                  color: Colors.teal),
                              onPressed: () {
                                setState(() {
                                  if (item.quantity > 1) {
                                    item.quantity--;
                                  } else {
                                    cartItems.removeAt(index);
                                  }
                                  calculateTotal();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LeagueSpartan'),
                    ),
                    const Text(
                      'Used cupons: All Pasta',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C8C75),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.home, color: Colors.teal),
                    Icon(Icons.favorite_border, color: Colors.teal),
                    Icon(Icons.shopping_cart, color: Colors.teal),
                    Icon(Icons.person_outline, color: Colors.teal),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
