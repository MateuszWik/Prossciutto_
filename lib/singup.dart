import 'package:flutter/material.dart';
import 'package:mateusz/account.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingupScreen(),
    );
  }
}

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C8C75), // Kolor tła
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Log in',
                  style: TextStyle(
                    fontFamily: "LeagueSpartan",
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13), // 13px odstępu z lewej i prawej
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(fontFamily: "MontSerrat"),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16), // Zaokrąglone rogi
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 23),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13), // 13px odstępu z lewej i prawej
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16), // Zaokrąglone rogi
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 103),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13), // Odstęp 13px po obu stronach
                  child: SizedBox(
                    height: 65, // Ustawiona wysokość przycisku
                    width: double.infinity, // Pełna szerokość (minus padding)
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Account()), // Przejście na nową stronę
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Czarny kolor tła
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19), // Zaokrąglone rogi 16px
                        ),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(fontFamily:"LeagueSpartan" ,color: Colors.white, fontSize: 27),
                      ),
                    ),
                  ),
                )

              ]
          ),
        ),
      ),
    );
  }
}
