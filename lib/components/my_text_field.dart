import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String lableText;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.lableText,
    required this.obscureText,
    this.toggleVisibility,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPassword = lableText.toLowerCase() == 'password';
    final bool isConfirmPassword =
        lableText.toLowerCase() == 'confirm password';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: SizedBox(
        //width: double.infinity,
        child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            cursorColor: const Color(0xff107163),
            style: const TextStyle(color: Color(0xff107163)),
            inputFormatters: inputFormatters,
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
              suffixIcon: isPassword || isConfirmPassword
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
                return 'Please enter a $lableText.';
              }

              if (lableText.toLowerCase() == 'age') {
                if (!RegExp(r'^[0-9/]+$').hasMatch(value.trim())) {
                  return 'Age must contain only numbers and slashes.';
                }
              }

              if (isPassword && value.length < 8) {
                return 'Password must be at least 8 characters long.';
              }
              if (lableText.toLowerCase() == 'mobile number') {
                if (!RegExp(r'^\d{10,15}$').hasMatch(value.trim())) {
                  return 'Enter a valid mobile number';
                }
              }

              return null;
            }),
      ),
    );
  }
}
