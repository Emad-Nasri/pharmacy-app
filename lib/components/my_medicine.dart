import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/pages/details_page.dart';

// ignore: must_be_immutable
class MyMedicine extends StatelessWidget {
  MyMedicine({
    super.key,
    required this.image,
    required this.medName,
    required this.price,
    required this.description,
    required this.useage,
    required this.quantity,
    required this.startD,
    required this.startM,
    required this.startY,
    required this.endD,
    required this.endM,
    required this.endY,
    this.barcode, // صار nullable
  });

  String image;
  String medName;
  String description;
  String useage;
  String? barcode; // nullable
  double price;
  int quantity;
  int startD;
  int startM;
  int startY;
  int endD;
  int endM;
  int endY;

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
              startD: startD,
              startM: startM,
              startY: startY,
              endD: endD,
              endM: endM,
              endY: endY,
              barcode: barcode ?? '', // لو null رح نعطيها قيمة فارغة
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
