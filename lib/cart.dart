import 'package:flutter/material.dart';
import 'package:mateusz/login.dart';
import './account.dart';
import './main.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
        page = LoginScreen();
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
  int cena = 20;
  String kupon = 'none';
  double wynik = 0;

  void saveIlosc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('ilosc', ilosc);
  }

  void loadIlosc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ilosc = prefs.getInt('ilosc') ?? 1;
    });
  }

  void total() async {
    setState(() {
      wynik = ilosc * cena.toDouble();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('wynik', wynik);
  }

  void loadTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wynik = prefs.getDouble('wynik') ?? 0.0;
    });
  }




  @override
  void initState() {
    super.initState();
    loadIlosc();
    loadTotal();
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
          if (ilosc > 0)...[
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
                        height: 100,
                        width: 235,
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
                        margin: EdgeInsets.only(top: 35), // dopasowanie do wysokości
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
                                    total();
                                    saveIlosc();
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
                                  total();
                                  saveIlosc();
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
                    padding: EdgeInsets.only(top: 385),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total: $wynik',
                          style: TextStyle(
                            fontFamily: 'Leauge Spartan',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Used coupons: $kupon',
                          style: TextStyle(
                            fontFamily: 'Leauge Spartan',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ]
          else if(ilosc <=0)...[
            Align(
         alignment: Alignment.center,
        child: Text(
          'Cart is empty',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Leauge Spartan',
            fontWeight: FontWeight.bold
          ),
      ),
    )
            ]
        ],
      ),
    );
    }

}

