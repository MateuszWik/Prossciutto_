import 'package:flutter/material.dart';
import '../main.dart';
import 'package:mateusz/cart.dart';
import 'package:mateusz/account.dart';
import 'data/favorites_data.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Testowa",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF3ECE4)),

      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePage();
}
class _HomePage extends State<HomePage>{
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Menu();
        break;
      case 1:
        page = Favorites();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
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

          // Pasek dolny jako warstwa
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
                        icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined,),
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
class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Favorites',
                style: TextStyle(
                  fontFamily: 'LeagueSpartan',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: (favoriteItems?.isEmpty ?? true)
                  ? Center(
                child: Text(
                  "Brak ulubionych dań",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: 277,
                      height: 88,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C8C75),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.asset(
                                  item.imagePath,
                                  width: 132,
                                  height: 88,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: '${item.name}\n\n',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: item.price,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  favoriteItems.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
