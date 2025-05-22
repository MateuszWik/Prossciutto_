import 'package:flutter/material.dart';
import 'package:mateusz/account.dart';
import 'package:mateusz/login.dart';
import 'package:get_storage/get_storage.dart';
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
  final box = GetStorage();

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3ECE4),
      body: Stack(
        children: [
          // 🔹 Zielony box na dole
          // ZIELONY BOX NA DOLE – PRZYKLEJONY
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 715,
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
                  SizedBox(height: 15),
                  Padding(padding: EdgeInsets.only(top: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Menu()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/left_arrow.png",
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 80), //

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
                                  content: Text("Nie wszystkie pola są wypełnione!", style: TextStyle(color: Color(0xFF0C8C75))),
                                  backgroundColor: Colors.white,
                                ),
                              );
                              return;
                            }

                            List<Map<String, String>> users = box.read('users') ?? [];

                            bool emailExists = users.any((user) => user['email'] == emailController.text);

                            if (emailExists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Ten email już istnieje!", style: TextStyle(color: Color(0xFF0C8C75))),
                                  backgroundColor: Colors.white,
                                ),
                              );
                              return;
                            }

                            Map<String, String> newUser = {
                              'name': nameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                              'dateOfBirth': "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}", // ✅ Dodaj zapis daty urodzenia
                            };
                            box.write('userDateOfBirth', newUser['dateOfBirth']); // ✅ Zapis daty urodzenia



                            users.add(newUser);
                            box.write('users', users);
                            box.write('isLoggedIn', true);
                            box.write('userName', newUser['name']);
                            box.write('userEmail', newUser['email']);
                            box.write('userPassword', newUser['password']);
                            box.write('userDateOfBirth', newUser['dateOfBirth']);

                            // 🔁 ZAMIANA AccountPage NA Menu:
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Menu()),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}