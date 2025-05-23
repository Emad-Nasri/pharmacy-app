import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_button.dart';
import 'package:pharmacy_app/components/my_text_field.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/pages/home_page.dart';
import 'package:pharmacy_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  void singUserIn() {
    // login logic
    if (_formKey.currentState!.validate()) {
      /*Map<String, dynamic> data = {
        'userName': usernameController.text,
        'password': passwordController.text,
      };*/
      //AuthService.login(data);
      Get.off(const HomePage());
    }
    // إذا لم تكن الحقول صالحة، لن يتم تنفيذ شيء
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
          child: ListView(
            children: [
              Form(
                key: _formKey, // ربط النموذج بالمفتاح
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // logo
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

                    //welcome back, you have been missed!
                    Text(
                      'welcome back, you have been missed!',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),

                    const SizedBox(height: 25),

                    const Padding(
                      padding: EdgeInsets.only(right: 200, bottom: 12),
                      child: Text('Enter your username'),
                    ),

                    //username text field
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      lableText: 'Username',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.only(right: 200, bottom: 12),
                      child: Text('Enter your password'),
                    ),

                    //password text field
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      lableText: 'Password',
                      obscureText: showPassword,
                      toggleVisibility: togglePasswordVisibility,
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 25),

                    MyButton(onTap: singUserIn),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
