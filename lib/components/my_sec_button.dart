import 'package:flutter/material.dart';

class MySecButton extends StatelessWidget {
  const MySecButton({super.key, required this.color, required this.onTap});
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(25),
        child: const Center(
          child: Icon(Icons.sunny),
        ),
      ),
    );
  }
}
