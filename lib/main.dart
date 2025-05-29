import 'package:flutter/material.dart';
import 'miniatures.dart';
import 'login.dart';
import 'cart.dart';
import 'coupons.dart';
import 'favorites.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  List<dynamic> dynamicList = box.read('users') ?? [];
  List<Map<String, String>> users = dynamicList.map((e) => Map<String, String>.from(e)).toList();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF3ECE4),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff3ece4)),
      ),
      home: Menu(),
    );
  }
}

class FoodItems {
  final String name;
  final String imagePath;
  final String price;

  FoodItems({required this.name, required this.imagePath, required this.price});
}

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  String? userEmail;
  String? userDateOfBirth;
  int? userAge;

  var selectedIndex = 0;
  String searchQuery = '';
  List<FoodItems> favoriteItems = [];

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }
  bool isLoggedIn = false;
  String? userName;

  void loadUserData() {
    final box = GetStorage();
    isLoggedIn = box.read('isLoggedIn') ?? false;
    userName = isLoggedIn ? box.read('userName') : null;

  }


  @override
  void initState() {
    super.initState();
    loadUserData();
  }



  void toggleFavorite(FoodItems item) {
    setState(() {
      if (favoriteItems.any((element) => element.name == item.name)) {
        favoriteItems.removeWhere((element) => element.name == item.name);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  bool isFavorite(String name) {
    return favoriteItems.any((item) => item.name == name);
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeScreen(
          onAccTap: () {
            setState(() {
              selectedIndex = 4;
            });
          },
          searchQuery: searchQuery,
          onSearchChanged: updateSearch,
          toggleFavorite: toggleFavorite,
          isFavorite: isFavorite,
          userName: userName,
        );

        break;
      case 1:
        page = Favorites(
          favoriteItems: favoriteItems,
          toggleFavorite: toggleFavorite,
          isFavorite: isFavorite,
        );
        break;
      case 2:
        page = Coupons(
          userEmail: userEmail,
          userAge: userAge,
        );
        break;

      case 3:
        page = Cart();
        break;
      case 4:
        Future.microtask(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
          setState(() {
            selectedIndex = 0;
          });
        });
        page = SizedBox.shrink();
        break;

      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    Color navBarColor = selectedIndex == 2|| selectedIndex == 4
        ? Color(0xFFF3ECE4)
        : Color(0xFF0C8C75);

    Color iconColor = selectedIndex == 2 || selectedIndex == 4
        ? Color(0xFF0C8C75)
        : Colors.white;




    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: colorScheme.surfaceContainerHighest,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: page,
              ),
            ),
          ),
          if (selectedIndex != 4)
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
                    color: navBarColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                          color: iconColor,
                          onPressed: () => setState(() => selectedIndex = 0),
                        ),
                        IconButton(
                          icon: Icon(selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined),
                          color: iconColor,
                          onPressed: () => setState(() => selectedIndex = 1),
                        ),
                        IconButton(
                          icon: Icon(selectedIndex == 2 ? Icons.local_offer : Icons.local_offer_outlined),
                          color: iconColor,
                          onPressed: () => setState(() => selectedIndex = 2),
                        ),
                        IconButton(
                          icon: Icon(selectedIndex == 3 ? Icons.shopping_cart: Icons.shopping_cart_outlined),
                          color: iconColor,
                          onPressed: () => setState(() => selectedIndex = 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  final VoidCallback onAccTap;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final Function(FoodItems) toggleFavorite;
  final bool Function(String) isFavorite;
  final String? userName;

  const HomeScreen({
    super.key,
    required this.onAccTap,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.toggleFavorite,
    required this.isFavorite,
    this.userName,
  });


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.searchQuery);
    searchController.addListener(() {
      widget.onSearchChanged(searchController.text);
    });
  }
  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery != searchController.text) {
      searchController.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool _matches(String query, String name) =>
      name.toLowerCase().contains(query.toLowerCase());

  @override
  Widget build(BuildContext context) {
    final pastaItems = [
      FoodItems(name: 'Macaroni', imagePath: 'assets/images/Macaroni.png', price: '20\$'),
      FoodItems(name: 'Spaghetti Sicily', imagePath: 'assets/images/Spaghetti-Sicily.png', price: '25\$'),
      FoodItems(name: "Penne all' Arrabbiata", imagePath: 'assets/images/Penne_all_arrabbiata.png', price: '25\$'),
    ];
    final pizzaItems = [
      FoodItems(name: 'Pizza Margherita', imagePath: 'assets/images/Margherita.png', price: '15\$'),
      FoodItems(name: 'Pizza Prosciutto e Funghi', imagePath: 'assets/images/Prosciutto_e_funghi.png', price: '25\$'),
      FoodItems(name: 'Pizza Quattro Formaggi', imagePath: 'assets/images/Quattro_Formaggi.png', price: '25\$'),
    ];
    final sideItems = [
      FoodItems(name: 'Frantonio Oil', imagePath: 'assets/images/Frantoio-Oil.png', price: '3\$'),
      FoodItems(name: 'Leccino Oil', imagePath: 'assets/images/Leccino-Oil.png', price: '4\$'),
      FoodItems(name: 'Water', imagePath: 'assets/images/Water.png', price: 'Free of Charge'),
      FoodItems(name: 'Bread Sticks', imagePath: 'assets/images/bread_sticks.png', price: 'Free of Charge'),
    ];

    final sections = [
      {'title': 'Pasta', 'items': pastaItems},
      {'title': 'Pizza', 'items': pizzaItems},
      {'title': 'Sides', 'items': sideItems},
    ];

    final filteredSections = sections.map((section) {
      final items = (section['items'] as List<FoodItems>)
          .where((item) => _matches(searchController.text, item.name))
          .toList();
      return {'title': section['title'], 'items': items};
    }).where((section) => (section['items'] as List).isNotEmpty).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi${widget.userName != null ? ' ${widget.userName}' : ''}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: widget.onAccTap,
                    child: Icon(
                      Icons.person,
                      size: 28,
                      color: Colors.grey,
                    ),
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
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'search...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              ...filteredSections.map((section) {
                final title = section['title'] as String;
                final items = section['items'] as List<FoodItems>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: items.map((item) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              final index = foodItems.indexWhere((e) => e.imagePath == item.imagePath);
                              if (index != -1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodDetailScreen(selectedIndex: index),
                                  ),
                                );
                              }
                            },
                            child: _buildFoodCard(item: item, isFavorited: widget.isFavorite(item.name)),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                );
              }).toList(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFoodCard({required FoodItems item, required bool isFavorited}) {
    return Container(
      width: 150,
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
            child: Image.asset(
              item.imagePath,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            item.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: Column(
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.price,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => widget.toggleFavorite(item),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                        size: 24,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







