import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_app/components/my_button.dart';
import 'package:pharmacy_app/components/my_text_field.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/pages/home_page.dart';
import 'package:pharmacy_app/pages/login.dart';
import 'package:pharmacy_app/services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  void singUserUp() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        // كلمة السر وتأكيدها لا تتطابق
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return; // إيقاف المتابعة
      }

      // إذا تطابقت كلمة السر مع تأكيدها، انتقل إلى الصفحة الرئيسية
      Get.off(const HomePage());
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                    obscureText: showPassword,
                    toggleVisibility: togglePasswordVisibility,
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your age (e.g. 25/10)'),
                    ),
                  ),
                  MyTextField(
                    controller: ageController,
                    hintText: 'Age ',
                    lableText: 'Age',
                    obscureText: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('Enter your mobile number'),
                    ),
                  ),
                  MyTextField(
                    controller: phoneController,
                    hintText: 'Mobile Number',
                    lableText: 'Mobile Number',
                    obscureText: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
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
                  Text(''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
