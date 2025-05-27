import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.catName});
  final String catName;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          catName,
          style: TextStyle(color: iconColor),
        ),
      ),
      body: ListView(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 3.5,
            children: const [
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
