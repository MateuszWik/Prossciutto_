import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeScreen(onCouponTap: () {
          setState(() {
            selectedIndex = 4;
          });
        });
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

  const HomeScreen({super.key, required this.onCouponTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: onCouponTap,
                    child: Image.asset('assets/images/kupon.png'),
                  ),
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
              SizedBox(height: 24),
              Text('Pasta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFoodCard(
                        imagePath: 'assets/images/Macaroni.png',
                        name: 'Macaroni\nCampania',
                        price: '20\$'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/Spaghetti-Sicily.png',
                        name: 'Spaghetti\nSicily',
                        price: '25\$'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/Penne_all_arrabbiata.png',
                        name: 'Penne all\'\nArrabbiata',
                        price: '25\$'
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text('Pizza', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFoodCard(
                        imagePath: 'assets/images/Margherita.png',
                        name: 'Pizza \nMargherita',
                        price: '15\$'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/Prosciutto_e_funghi.png',
                        name: 'Pizza \nProsciutt funghi',
                        price: '25\$'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/Quattro_Formaggi.png',
                        name: 'Pizza \nQuattro Formaggi',
                        price: '25\$'
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text('Sides', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFoodCard(
                        imagePath: 'assets/images/Frantoio-Oil.png',
                        name: 'Frantonio Oil',
                        price: '3\$'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/Leccino-Oil.png',
                        name: 'Leccino Oil',
                        price: '4\$'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/Water.png',
                        name: 'Water',
                        price: 'Free of Charge'
                    ),
                    SizedBox(width: 12),
                    _buildFoodCard(
                        imagePath: 'assets/images/bread_sticks.png',
                        name: 'Bread Sticks',
                        price: 'Free of Charge'
                    ),
                  ],
                ),
              ),
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