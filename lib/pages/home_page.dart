import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/components/my_category.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/controllers/category_controller.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/pages/scanner_page.dart';
import 'package:pharmacy_app/pages/notification_page.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';
import 'package:pharmacy_app/variabels/theme_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const Drawer(width: 200, child: MyDrawer()),
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          S.of(context).home,
          style: TextStyle(color: iconColor),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: iconColor),
                onPressed: () => Get.to(const NotificationPage()),
              ),
              Icon(Icons.wb_sunny, color: iconColor),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeController.toggleTheme();
                },
                activeColor: iconColor,
                activeTrackColor: Colors.grey.shade600,
                inactiveThumbColor: iconColor,
                inactiveTrackColor: Colors.grey.shade400,
              ),
              Icon(Icons.nightlight_round, color: iconColor),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment:
                    isArabic() ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  S.of(context).category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.yellow : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryController.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 3.5,
                ),
                itemBuilder: (context, index) {
                  final cat = categoryController.categories[index];
                  return MyCategory(
                    catName: cat.name,
                    image: cat.image ?? 'logo.png',
                  );
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? Colors.grey.shade800 : Colors.white,
                  foregroundColor: isDarkMode ? Colors.yellow : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  minimumSize: const Size(0, 0),
                  maximumSize: const Size(250, 50),
                  side: const BorderSide(
                    color: Color(0xff107163),
                    width: 2,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Get.to(const ScannerPage());
                  print('go to scanner page');
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/barcode.png', height: 50),
                    Text(S.of(context).open_barcode_scanner),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
