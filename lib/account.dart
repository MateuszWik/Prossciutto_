import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mateusz/login.dart';
import 'main.dart';
import 'cart.dart';
import 'favorites.dart';
import 'coupons.dart';

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
  int selectedIndex = 4;
  final box = GetStorage();
  bool isPasswordVisible = false; // ✅ Przechowuje stan widoczności hasła


  void logoutUser(BuildContext context) {
    box.write('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Widget getSelectedPage() {
    switch (selectedIndex) {
      case 0:
        return Menu();
      case 1:
        return Favorites(
          favoriteItems: [],
          toggleFavorite: (_) {},
          isFavorite: (_) => false,
        );
      case 2:
        return Coupons();
      case 3:
        return Cart(dateOfBirth: widget.dateOfBirth);
      case 4:
      default:
        return accountContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color navBarColor = selectedIndex == 2 ? Color(0xFFF3ECE4) : Color(0xFF0C8C75);
    Color iconColor = selectedIndex == 2 ? Color(0xFF0C8C75) : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: getSelectedPage()),
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
                        icon: Icon(selectedIndex == 3 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
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
          ),//s
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/images/kotek.png'),
          ),
          SizedBox(height: 23),
          buildInfoField("Name", widget.name),
          buildInfoField("Email", widget.email),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            isPasswordVisible ? widget.password : "●●●●●●●●●●",
                            style: TextStyle(fontSize: 16, fontFamily: "MontSerrat", color: Colors.black54),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible; // ✅ Zmiana stanu widoczności
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          buildInfoField("Date of Birth", widget.dateOfBirth),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => logoutUser(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0C8C75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                "Sign out",
                style: TextStyle(fontSize: 14, fontFamily: "LeagueSpartan", color: Colors.white),
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
