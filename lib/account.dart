import 'package:flutter/material.dart';
import 'package:mateusz/Account.dart';
import 'package:mateusz/singup.dart';
import 'package:mateusz/main.dart';
import 'package:mateusz/favorites.dart';
import 'package:mateusz/cart.dart';
import 'package:mateusz/coupons.dart';

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
      home: Account(),
    );
  }
}

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}
class _Account extends State<Account>{
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
        page = Cart();
        break;
      case 3:
        page = LoginScreen();
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



  @override
  Widget buildd(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text("Account",
              style: TextStyle(fontSize: 16, fontFamily: "LeagueSpartan",),),
          ),
        ),
        SizedBox(height: 15),
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage('assets/images/kotek.png'),
          // child: Icon(Icons.person, size: 40, color: Colors.white),
         ),
        SizedBox(height: 23),
        Padding(
            padding: EdgeInsets.only(left:13),
          child:Align(alignment: Alignment.centerLeft,
              child:Text("Name",style: TextStyle(fontSize: 14,fontFamily: "LeagueSpartan" ),
              ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Container(
            height: 23,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                   "Brak danych" ,
                  style: TextStyle(fontSize: 16, fontFamily: "MontSerrat"),
                ),
              ),
            ),
          ),
        ),
            SizedBox(height: 10),
    Padding(
    padding: EdgeInsets.only(left:13),
    child:Align(alignment: Alignment.centerLeft,
    child:Text("Email",style: TextStyle(fontSize: 14,fontFamily: "LeagueSpartan" ),
    ),
    ),
    ),
    SizedBox(height: 5),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 13),
    child: Container(
    height: 23,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Align(
    alignment: Alignment.centerLeft,
    child: Text(
    "Brak danych" ,
    style: TextStyle(fontSize: 16, fontFamily: "MontSerrat"),
    ),
    ),
    ),
    ),
    ), SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left:13),
          child:Align(alignment: Alignment.centerLeft,
            child:Text("Password",style: TextStyle(fontSize: 14,fontFamily: "LeagueSpartan" ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Container(
            height: 23,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Brak danych" ,
                  style: TextStyle(fontSize: 16, fontFamily: "MontSerrat"),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left:13),
          child:Align(alignment: Alignment.centerLeft,
            child:Text("Date of Birth",style: TextStyle(fontSize: 14,fontFamily: "LeagueSpartan" ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Container(
            height: 23,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Brak danych" ,
                  style: TextStyle(fontSize: 16, fontFamily: "MontSerrat"),
                ),
              ),
            ),
          ),
        ),
      ]
    );
  }
}