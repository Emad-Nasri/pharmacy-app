import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pharmacy_app/pages/details_page.dart';

class MyMedicine extends StatelessWidget {
  const MyMedicine(
      {super.key,
      required this.image,
      required this.medName,
      required this.price,
      required this.description,
      required this.useage,
      required this.quantity});
  final String image;
  final String medName;
  final String description;
  final String useage;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailsPage(
              productName: medName,
              description: description,
              price: price,
              useage: useage,
              quantity: quantity,
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
              child: Column(
                children: [
                  Text(
                    medName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.yellow : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$price \$',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.yellow : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
