import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';
import 'package:pharmacy_app/controllers/product_category_controller.dart';

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({super.key, required this.catName});
  final String catName;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;

    final c = Get.put(ProductCategoryController(catName: catName));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(catName, style: TextStyle(color: iconColor)),
        actions: [
          IconButton(
            onPressed: () => c.fetchProducts(),
            icon: Icon(Icons.refresh, color: iconColor),
          )
        ],
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (c.error.value != null) {
          return Center(child: Text('حدث خطأ:\n${c.error.value}'));
        }
        if (c.products.isEmpty) {
          return const Center(child: Text('لا توجد عناصر'));
        }

        return ListView(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: c.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 3.5,
              ),
              itemBuilder: (_, i) {
                final p = c.products[i];

                return MyMedicine(
                  medName: p.name,
                  price: (p.sellPrice ?? 0).toDouble(),
                  description: p.description ?? '',
                  useage: '', // غير متوفر في الرد
                  quantity: p.minimumStockLevel ?? 0,
                  startD: 1, startM: 1, startY: 2024, // قيم افتراضية
                  endD: 1, endM: 1, endY: 2026,
                  barcode: '', // غير متوفر في الرد
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
