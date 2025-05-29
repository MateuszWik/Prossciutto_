import 'package:flutter/material.dart';
import 'package:mateusz/login.dart';
import 'package:get_storage/get_storage.dart';
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DateTime? selectedDate;
  final box = GetStorage();

  bool isPasswordVisible = false;
  bool isButtonEnabled = false;

  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      checkFields();
    }
  }

  void checkFields() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          selectedDate != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF3ECE4),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 715,
              decoration: const BoxDecoration(
                color: Color(0xFF0C8C75),
                borderRadius: BorderRadius.vertical(top: Radius.circular(33)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 9),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>  Menu()),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage("assets/images/left_arrow.png"),
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: "LeagueSpartan",
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: TextFormField(
                        controller: nameController,
                        onChanged: (_) => checkFields(),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (_) => checkFields(),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Email must contain "@"';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),

                    // Password Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: TextFormField(
                        controller: passwordController,
                        onChanged: (_) => checkFields(),
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
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
                    const SizedBox(height: 23),

                    // Date of Birth Picker
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: InkWell(
                        onTap: () => pickDate(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            selectedDate == null
                                ? "Select Date of Birth"
                                : "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
                            style: const TextStyle(fontFamily: "MontSerrat", fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),

                    // Sign Up Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: SizedBox(
                        height: 65,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isButtonEnabled
                              ? () {
                            if (!_formKey.currentState!.validate()) return;

                            List<Map<String, String>> users =
                                box.read('users')?.cast<Map<String, String>>() ?? [];

                            bool emailExists = users.any(
                                  (user) => user['email'] == emailController.text.trim(),
                            );

                            if (emailExists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Ten email już istnieje!",
                                      style: TextStyle(color: Color(0xFF0C8C75))),
                                  backgroundColor: Colors.white,
                                ),
                              );
                              return;
                            }

                            final newUser = {
                              'name': nameController.text.trim(),
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim(),
                              'dateOfBirth':
                              selectedDate!.toIso8601String().split('T').first,
                            };

                            users.add(newUser);
                            box.write('users', users);
                            box.write('isLoggedIn', true);
                            box.write('userName', newUser['name']);
                            box.write('userEmail', newUser['email']);
                            box.write('userPassword', newUser['password']);
                            box.write('userDateOfBirth', newUser['dateOfBirth']);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>  Menu()),
                            );
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: "LeagueSpartan",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Switch to Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontFamily: "MontSerrat",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
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
          ),
        ],
      ),
    );
  }
}
