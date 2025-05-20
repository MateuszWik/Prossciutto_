import 'package:flutter/material.dart';
import 'package:mateusz/account.dart';
import 'package:mateusz/login.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  DateTime? selectedDate;

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }


  bool isButtonEnabled = false;

  void checkFields() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          selectedDate != null; // ✅ Sprawdza, czy użytkownik wybrał datę
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: Stack(
        children: [
          // 🔹 Zielony box na dole
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 770,
              decoration: BoxDecoration(
                color: Color(0xFF0C8C75),
                borderRadius: BorderRadius.vertical(top: Radius.circular(33)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100), //

                  Text(
                    'Sign Up',
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
                      controller: nameController,
                      onChanged: (text) => checkFields(),
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                      controller: emailController,
                      onChanged: (text) => checkFields(),
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
                      controller: passwordController,
                      onChanged: (text) => checkFields(),
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
                  SizedBox(height: 23),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13), // ✅ Odstęp 13px z każdej strony
                    child: InkWell(
                      onTap: () => pickDate(context),
                      child: Container(
                        width: double.infinity, // ✅ Pełna szerokość ekranu
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 13), // ✅ Dopasowanie do inputów
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          selectedDate == null
                              ? "Select Date of Birth"
                              : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                          style: TextStyle(fontFamily: "MontSerrat", fontSize: 16),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 80),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      height: 65,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              selectedDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Nie wszystkie pola są wypełnione!",style: TextStyle(color: Color(0xFF0C8C75)),),
                                backgroundColor: Colors.white,

                              ),
                            );
                            return; // ✅ Jeśli pola są puste, wyświetla komunikat i nie przechodzi dalej
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountPage(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                dateOfBirth: "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // ✅ Zawsze czarne tło
                          foregroundColor: Colors.white, // ✅ Tekst zawsze biały
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontFamily: "LeagueSpartan", color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontFamily: "MontSerrat", fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontFamily: "MontSerrat",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 🔹 Pasek nawigacyjny (NavBar)
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
                  color: Color(0xFFF3ECE4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(icon: Icon(Icons.home_outlined), color: Color(0xFF0C8C75), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
                      }),
                      IconButton(icon: Icon(Icons.favorite_border_outlined), color: Color(0xFF0C8C75), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Placeholder()));
                      }),
                      IconButton(icon: Icon(Icons.shopping_cart_outlined), color: Color(0xFF0C8C75), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Card()));
                      }),
                      IconButton(icon: Icon(Icons.person_2_outlined), color: Color(0xFF0C8C75), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      }),
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