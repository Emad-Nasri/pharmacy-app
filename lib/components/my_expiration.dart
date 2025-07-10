import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/pages/details_page.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class MyExpiration extends StatelessWidget {
  const MyExpiration({
    super.key,
    this.image,
    this.medName,
    this.description,
    this.useage,
    this.price,
    this.quantity,
    this.startD,
    this.startM,
    this.startY,
    this.endD,
    this.endM,
    this.endY,
  });

  final String? image;
  final String? medName;
  final String? description;
  final String? useage;
  final double? price;
  final int? quantity;
  final int? startD;
  final int? startM;
  final int? startY;
  final int? endD;
  final int? endM;
  final int? endY;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;
    final boxDecorationColor =
        isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;
    final textColor = isDarkMode ? Colors.yellow : Colors.black;
    final borderColor = isDarkMode ? Colors.yellow : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          'Expiration date',
          style: TextStyle(color: iconColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          GestureDetector(
            onTap: () {
              if (medName != null &&
                  description != null &&
                  useage != null &&
                  price != null &&
                  quantity != null &&
                  startD != null &&
                  startM != null &&
                  startY != null &&
                  endD != null &&
                  endM != null &&
                  endY != null) {
                Get.to(DetailsPage(
                  productName: medName!,
                  description: description!,
                  price: price!,
                  useage: useage!,
                  quantity: quantity!,
                  endD: endD!,
                  endM: endM!,
                  endY: endY!,
                  startD: startD!,
                  startM: startM!,
                  startY: startY!,
                ));
              } else {
                Get.snackbar(
                  'Wrong Data',
                  'Some data is missing and details cannot be displayed.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: boxDecorationColor,
                  border: Border.all(color: borderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // صورة المنتج
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Image.asset(
                            'assets/images/${image ?? "sad.png"}',
                            height: 100,
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // تفاصيل المنتج
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Name: ${medName ?? "Unknown"}',
                              style: TextStyle(color: textColor),
                            ),
                            Text(
                              'Price: ${price?.toStringAsFixed(2) ?? "N/A"}\$',
                              style: TextStyle(color: textColor),
                            ),
                            Text(
                              'Total Quantity: ${quantity ?? "N/A"}',
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
