import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmacy_app/components/theme_controller.dart';
import 'package:pharmacy_app/pages/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      themeMode: themeController.theme,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          background: Colors.grey[300]!,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF121212),
        ),
      ),
    );
  }
}
