import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart'; // Dodano GetStorage
import 'package:mateusz/login.dart';
import 'main.dart';
import 'cart.dart';

class AccountPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String dateOfBirth;

  const AccountPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.dateOfBirth,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var selectedIndex = 3; // Ustawiony na 'Account' domyślnie
  final box = GetStorage();

  void logoutUser() {
    box.remove('isLoggedIn');
    box.remove('userName');
    box.remove('userEmail');
    box.remove('userPassword');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

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
        break;
      case 3:
        page = accountContent();
        break;
      default:
        throw UnimplementedError('Nie znaleziono widoku dla $selectedIndex');
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: page),
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
          ),
        ],
      ),
    );
  }

  Widget accountContent() {
    return Container(
      color: Color(0xFFF3ECE4),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Account",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "LeagueSpartan",
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
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
          buildInfoField("Name", widget.name),
          buildInfoField("Email", widget.email),
          buildInfoField("Password", widget.password),
          buildInfoField("Date of Birth", widget.dateOfBirth),
          SizedBox(height: 40),

          // 🔹 Przycisk "Wyloguj"
          ElevatedButton(
            onPressed: logoutUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Czerwony przycisk dla wylogowania
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                "Wyloguj",
                style: TextStyle(fontSize: 18, fontFamily: "LeagueSpartan", color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontFamily: "LeagueSpartan", fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400, width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, fontFamily: "MontSerrat", color: Colors.black54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}