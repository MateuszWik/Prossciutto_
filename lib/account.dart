import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart';
import 'cart.dart';

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
  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Menu(); // Twój widget menu
        break;
      case 1:
        page = Placeholder(); // Tu możesz wstawić np. FavoritePage()
        break;
      case 2:
        page = Cart(); // Twój widget koszyka
        break;
      case 3:
        page = LoginScreen(); // Nowy widget z widokiem konta
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()), // Otwiera ekran logowania jako osobną stronę
                            );
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

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Account",
                style: TextStyle(fontSize: 20, fontFamily: "LeagueSpartan"),
              ),
            ),
          ),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/images/kotek.png'),
          ),
          SizedBox(height: 23),
          buildInfoField("Name", "Brak danych"),
          buildInfoField("Email", "Brak danych"),
          buildInfoField("Password", "Brak danych"),
          buildInfoField("Date of Birth", "Brak danych"),
        ],
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14, fontFamily: "LeagueSpartan")),
          SizedBox(height: 5),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, fontFamily: "MontSerrat"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}