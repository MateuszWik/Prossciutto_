import 'package:flutter/material.dart';
import 'package:mateusz/login.dart';
import './account.dart';
import './cart.dart';
import './coupons.dart';
import './favorites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Menu",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF3ECE4)),
      ),
      home: Menu(),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  var selectedIndex = 0;
  String searchQuery = '';

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeScreen(
          onCouponTap: () {
            setState(() {
              selectedIndex = 4;
            });
          },
          searchQuery: searchQuery,
          onSearchChanged: updateSearch,
        );
        break;
      case 1:
        page = Favorites();
        break;
      case 2:
        page = Cart();
        break;
      case 3:
        page = Account();
        break;
      case 4:
        page = Coupons();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: mainArea),
          Positioned(
            left: 16,
            right: 16,
            bottom: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                elevation: 10,
                child: Container(
                  height: 60,
                  color: Color(0xFF0C8C75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(selectedIndex == 3 ? Icons.person_2 : Icons.person_2_outlined),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            selectedIndex = 3;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onCouponTap;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const HomeScreen({super.key, required this.onCouponTap, required this.searchQuery, required this.onSearchChanged});

  bool _matches(String query, String name) => name.toLowerCase().contains(query.toLowerCase());

  @override
  Widget build(BuildContext context) {
    final pastaItems = [
      {'image': 'assets/images/Macaroni.png', 'name': 'Macaroni Campania', 'price': '20\$'},
      {'image': 'assets/images/Spaghetti-Sicily.png', 'name': 'Spaghetti Sicily', 'price': '25\$'},
      {'image': 'assets/images/Penne_all_arrabbiata.png', 'name': "Penne all'Arrabbiata", 'price': '25\$'},
    ];

    final pizzaItems = [
      {'image': 'assets/images/Margherita.png', 'name': 'Pizza Margherita', 'price': '15\$'},
      {'image': 'assets/images/Prosciutto_e_funghi.png', 'name': 'Pizza Prosciutt funghi', 'price': '25\$'},
      {'image': 'assets/images/Quattro_Formaggi.png', 'name': 'Pizza Quattro Formaggi', 'price': '25\$'},
    ];

    final sideItems = [
      {'image': 'assets/images/Frantoio-Oil.png', 'name': 'Frantonio Oil', 'price': '3\$'},
      {'image': 'assets/images/Leccino-Oil.png', 'name': 'Leccino Oil', 'price': '4\$'},
      {'image': 'assets/images/Water.png', 'name': 'Water', 'price': 'Free of Charge'},
      {'image': 'assets/images/bread_sticks.png', 'name': 'Bread Sticks', 'price': 'Free of Charge'},
    ];

    Widget buildSection(String title, List items) {
      final filtered = items.where((item) => _matches(searchQuery, item['name']!)).toList();
      if (filtered.isEmpty) return SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filtered.map((item) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildFoodCard(
                  imagePath: item['image']!,
                  name: item['name']!,
                  price: item['price']!,
                ),
              )).toList(),
            ),
          ),
        ],
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Hi', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  InkWell(onTap: onCouponTap, child: Image.asset('assets/images/kupon.png')),
                ],
              ),
              SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  text: "It's not just ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                  children: [
                    TextSpan(text: "Food", style: TextStyle(color: Colors.teal)),
                    TextSpan(text: "\nIt's an "),
                    TextSpan(text: "Experience", style: TextStyle(color: Colors.teal)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'search...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              buildSection('Pasta', pastaItems),
              buildSection('Pizza', pizzaItems),
              buildSection('Sides', sideItems),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodCard({required String imagePath, required String name, required String price}) {
    return Container(
      width: 140,
      height: 180,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, height: 80, width: double.infinity, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.favorite_border_outlined, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
