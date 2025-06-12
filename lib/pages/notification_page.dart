import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Drawer(
        width: 200,
        child: MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          'Notifications',
          style: TextStyle(color: iconColor),
        ),
      ),
    );
  }
}
