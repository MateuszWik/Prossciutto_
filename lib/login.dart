import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mateusz/account.dart';
import 'package:mateusz/main.dart';
import 'package:mateusz/singup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final box = GetStorage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;

  void checkFields() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  void loginUser() {
    List<Map<String, String>> users = box.read('users') ?? [];

    // Sprawdzenie, czy użytkownik istnieje w bazie
    bool userExists = users.any((user) => user['email'] == emailController.text);

    if (!userExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nie istnieje konto na taki email. Zarejestruj się!", style: TextStyle(color: Color(0xFF0C8C75)),),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    // Jeśli konto istnieje, pobranie danych i przekierowanie do AccountPage
    Map<String, String> userData = users.firstWhere((user) => user['email'] == emailController.text);
    box.write('isLoggedIn', true);
    box.write('userName', userData['name']);
    box.write('userEmail', userData['email']);
    box.write('userPassword', userData['password']);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AccountPage(
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          password: userData['password'] ?? '',
          dateOfBirth: '',
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();

    // Automatyczne logowanie, jeśli użytkownik jest już zalogowany
    if (box.read('isLoggedIn') ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AccountPage(
              name: box.read('userName'),
              email: box.read('userEmail'),
              password: box.read('userPassword'),
              dateOfBirth: '',
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 630,
              decoration: BoxDecoration(
                color: Color(0xFF0C8C75),
                borderRadius: BorderRadius.vertical(top: Radius.circular(33)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  SizedBox(height: 80,),
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
                      controller: emailController,
                      onChanged: (text) => checkFields(),
                      style: TextStyle(fontFamily: "MontSerrat", fontSize: 16),
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
                  SizedBox(height: 80),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: SizedBox(
                      height: 65,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isButtonEnabled ? loginUser : () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        child: Text(
                          'Log in',
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
                        "Don't have an account?",
                        style: TextStyle(fontFamily: "MontSerrat", fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          "Sign Up",
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