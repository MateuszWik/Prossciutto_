import 'package:flutter/material.dart';
import 'package:mateusz/login.dart';
import './favorites.dart';
import './account.dart';
import './main.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF3ECE4)), // your beige color
      ),
      home: Menu(),
    );

  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePage();
}
class _HomePage extends State<HomePage>{
  var selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Menu();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = Cart();
      case 3:
        page = Account();
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
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int ilosc = 1;
  double wynik = 0;
  int cena = 20;
  String kupon = 'none';

  void total() {
    setState(() {
      wynik = (ilosc + cena) as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: Stack(
        children: [
          // Napis gorny Cart
          AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFF3ECE4),
            title: Text(
              'Cart',
              style: TextStyle(
                fontFamily: 'LeagueSpartan',
                fontSize: 25,
              ),
            ),
          ),
          // Tylko pokaż, jeśli ilosc > 0
          if (ilosc > 0)
            Positioned(
              left: 25,
              top: 130,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Blok: produkt
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFF0C8C75),
                          image: DecorationImage(
                            image: AssetImage('assets/images/Macaroni.png'),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        height: 130,
                        width: 310,
                        padding: EdgeInsets.all(7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Macaroni \n Campania',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\n$cena\$',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'MontSerrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10-3.6,),

                      // Blok: - 1 +
                      Container(
                        height: 40,
                        width: 120,
                        margin: EdgeInsets.only(top: 45), // dopasowanie do wysokości
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF0C8C75),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              iconSize: 24,
                              tooltip: 'Usuń',
                              onPressed: () {
                                setState(() {
                                  if (ilosc > 0) {
                                    ilosc--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$ilosc',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'MontSerrat',
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 24,
                              tooltip: 'Dodaj',
                              onPressed: () {
                                setState(() {
                                  ilosc++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 380
                    ),
                    child: Text(
                   'Total: $wynik',
                      style: TextStyle(
                        fontFamily: 'MontSerrat',
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:  500,
                      left: 1500
                    ),
                    child: Text(
                      'Used coupons: $kupon',
                      style: TextStyle(
                          fontFamily: 'MontSerrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),

        ],
      ),
    );
    }

}

