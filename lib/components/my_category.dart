import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/pages/category_page.dart';

class MyCategory extends StatelessWidget {
  const MyCategory({super.key, required this.catName, required this.image});
  final String catName;
  final String image;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Get.to(() => CategoryPage(
              catName: catName,
            ));
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? Colors.yellow : Colors.black,
            width: 1,
          ),
          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
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
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.yellow : Colors.black,
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
