import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

bool isArabic() {
  final locale = Get.locale ?? const Locale('ar');
  return locale.languageCode == 'ar';
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String lableText;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.lableText,
    required this.obscureText,
    this.toggleVisibility,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPassword = lableText.toLowerCase() == 'password';
    final bool isConfirmPassword =
        lableText.toLowerCase() == 'confirm password';

    final eyeIcon = IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        color: const Color(0xff107163),
      ),
      onPressed: toggleVisibility,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        cursorColor: const Color(0xff107163),
        style: const TextStyle(color: Color(0xff107163)),
        decoration: InputDecoration(
          labelText: lableText,
          labelStyle: const TextStyle(color: Color(0xff107163)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff107163)),
          suffixIcon: eyeIcon,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a $lableText.';
          }
          if (isPassword && value.length < 8) {
            return 'Password must be at least 8 characters long.';
          }
          return null;
        },
      ),
    );
  }
}
