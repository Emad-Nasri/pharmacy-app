import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pharmacy_app/components/my_button.dart';
import 'package:pharmacy_app/components/my_text_field.dart';
import 'package:pharmacy_app/pages/home_page.dart';
import 'package:pharmacy_app/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;
  bool showConfirmPassword = true;

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  Future<void> registerUser(Map<String, String> userData) async {
    final url =
        Uri.parse('https://your-backend-api.com/register'); // عدل الرابط هنا
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      // تسجيل ناجح، اذهب للصفحة الرئيسية
      Get.off(const HomePage());
    } else {
      final errorMsg =
          jsonDecode(response.body)['message'] ?? 'Registration failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
      );
    }
  }

  void singUserUp() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final userData = {
        "fullName": fullNameController.text.trim(),
        "username": usernameController.text.trim(),
        "phone": phoneController.text.trim(),
        "password": passwordController.text.trim(),
        "age": ageController.text.trim(),
      };

      try {
        await registerUser(userData);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'welcome back, you have been missed!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 25),

                  // Full Name
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your full name'),
                    ),
                  ),
                  MyTextField(
                    controller: fullNameController,
                    hintText: 'Full name',
                    lableText: 'Full name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  // Username
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your username'),
                    ),
                  ),
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    lableText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  // Phone number
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your phone number (starts with +963)'),
                    ),
                  ),
                  MyTextField(
                    controller: phoneController,
                    hintText: '+963xxxxxxxxx',
                    lableText: 'Phone',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your password'),
                    ),
                  ),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    lableText: 'Password',
                    obscureText: showPassword,
                    toggleVisibility: togglePasswordVisibility,
                  ),
                  const SizedBox(height: 10),

                  // Confirm Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Confirm your password'),
                    ),
                  ),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    lableText: 'Confirm password',
                    obscureText: showConfirmPassword,
                    toggleVisibility: toggleConfirmPasswordVisibility,
                  ),
                  const SizedBox(height: 10),

                  // Age
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your age (e.g. 25/10)'),
                    ),
                  ),
                  MyTextField(
                    controller: ageController,
                    hintText: 'Age (e.g. 25/10)',
                    lableText: 'Age',
                    obscureText: false,
                    keyboardType: TextInputType.text, // لإظهار السلاش
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    ],
                  ),
                  const SizedBox(height: 25),

                  MyButton(
                    onTap: singUserUp,
                    text: 'Sign Up',
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap: () => Get.off(const LoginPage()),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Login now',
                            style: TextStyle(
                              color: Color(0xff107163),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
