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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/$image',
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              catName,
              style: const TextStyle(
                  color: Color(0xff107163), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
