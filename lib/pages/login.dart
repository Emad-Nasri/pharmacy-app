import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/components/my_button.dart';
import 'package:pharmacy_app/components/my_text_field.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/generated/l10n.dart';
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
  bool isLoading = false;

  void singUserIn() async {
    /*if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final data = {
        'userName': usernameController.text.trim(),
        'password': passwordController.text.trim(),
      };

      try {
        final response = await AuthService.login(data);

        log(response.toString());

        if (response?['token'] != null) {
          Get.off(const HomePage());
        } else {
          Get.snackbar('Wrong', 'Login failed. Check data..',
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar('Wrong', 'An error occurred while logging in.',
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        setState(() => isLoading = false);
      }
    }*/
    Get.off(const HomePage());
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
                key: _formKey,
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
                      S.of(context).welcome,
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),

                    const SizedBox(height: 25),

                    //Enter your username

                    Padding(
                      padding: EdgeInsets.only(
                          right: isArabic() ? 20 : 200,
                          left: isArabic() ? 190 : 0,
                          bottom: 12),
                      child: Text(
                        S.of(context).enter_your_username,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),

                    //TextField for password

                    MyTextField(
                      controller: usernameController,
                      hintText: S.of(context).username,
                      lableText: S.of(context).username,
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.only(
                          right: isArabic() ? 0 : 200,
                          left: isArabic() ? 200 : 0,
                          bottom: 12),
                      child: Text(
                        S.of(context).enter_your_password,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),

                    MyTextField(
                      controller: passwordController,
                      hintText: S.of(context).password,
                      lableText: S.of(context).password,
                      obscureText: showPassword,
                      toggleVisibility: togglePasswordVisibility,
                    ),

                    const SizedBox(height: 25),

                    isLoading
                        ? Container(
                            width: 500,
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: const Color(0xff107163),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )))
                        : MyButton(
                            onTap: singUserIn,
                            text: S.of(context).sign_in,
                          ),

                    const SizedBox(height: 10),
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

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
