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
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C8C75),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Zawartość przesunięta bliżej góry
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/logo.png', width: 120, height: 120, fit: BoxFit.cover),
                ),
                SizedBox(height: 100),

                Text(
                  'Log in',
                  style: TextStyle(
                    fontFamily: "LeagueSpartan",
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(fontFamily: "MontSerrat"),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 23),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 103),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: SizedBox(
                    height: 65,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AccountPage()),
                        );

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(fontFamily:"LeagueSpartan" ,color: Colors.white, fontSize: 20),
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