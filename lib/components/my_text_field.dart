import 'package:flutter/material.dart';

//to username and password text field
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String lableText;
  final bool obscureText;
  final VoidCallback? toggleVisibility;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.lableText,
    required this.obscureText,
    this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPassword = lableText.toLowerCase() == 'password';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: const Color(0xff107163),
        style: const TextStyle(color: Color(0xff107163)),
        decoration: InputDecoration(
          label: Text(lableText),
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
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xff107163),
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'please enter a $lableText and dont let it empty';
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
