import 'package:flutter/material.dart';

class MyCategory extends StatelessWidget {
  const MyCategory({super.key, required this.catName, required this.image});
  final String catName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/$image',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: Text(
                catName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff107163),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
