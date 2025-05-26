import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mateusz/login.dart';
import 'package:mateusz/singup.dart';
import 'account.dart';
import 'package:mateusz/main.dart';

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
      debugShowCheckedModeBanner: false,
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
  bool isPasswordVisible = false;


  void checkFields() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  void loginUser() {
    List<Map<String, String>> users = box.read('users')?.cast<Map<String, String>>() ?? [];

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final userData = users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (userData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Niepoprawny email lub hasło.",
            style: TextStyle(color: Color(0xFF0C8C75)),
          ),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    box.write('isLoggedIn', true);
    box.write('userName', userData['name']);
    box.write('userEmail', userData['email']);
    box.write('userPassword', userData['password']);
    box.write('userDateOfBirth', userData['dateOfBirth'] ?? '');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Menu(),
      ),
    );
  }



  @override
  void initState() {
    super.initState();

    if (box.read('isLoggedIn') ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AccountPage(
              name: box.read('userName'),
              email: box.read('userEmail'),
              password: box.read('userPassword'),
              dateOfBirth: box.read('userDateOfBirth') ?? '',
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3ECE4),
      body: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 590,
              decoration: BoxDecoration(
                color: Color(0xFF0C8C75),
                borderRadius: BorderRadius.vertical(top: Radius.circular(33)),
              ),
            ),
          ),


          SingleChildScrollView(
            padding: const EdgeInsets.all(13),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 25),
                  Align(
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 55),
                  Text(
                    'Log in',
                    style: TextStyle(
                      fontFamily: "LeagueSpartan",
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // email
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
                  ),//s
                  SizedBox(height: 23),
                  // password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: TextFormField(
                      controller: passwordController,
                      onChanged: (text) => checkFields(),
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
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
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),

                        child: Text(
                          'Log in',
                          style: TextStyle(
                              fontFamily: "LeagueSpartan",
                              color: Colors.white,
                              fontSize: 20),
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
                        style: TextStyle(
                            fontFamily: "MontSerrat",
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
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
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}