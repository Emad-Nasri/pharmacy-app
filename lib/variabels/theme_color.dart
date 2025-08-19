import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

final ThemeController themeController = Get.find();

final isDarkMode = themeController.theme == ThemeMode.dark;
final appBarColor = isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
final iconColor = isDarkMode ? Colors.yellow : Colors.white;

final textColor = isDarkMode ? Colors.yellow : Colors.black;
final appBarTextColor = isDarkMode ? Colors.yellow : Colors.white;

final tabBarColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
final boxDecorationColor =
    isDarkMode ? Colors.grey.shade800 : const Color(0xff107163);
final borderColor = isDarkMode ? Colors.yellow : Colors.black;
final settingColor =
    isDarkMode ? Colors.yellow : const Color.fromARGB(255, 177, 170, 170);
final menuColor = isDarkMode ? Colors.yellow : Colors.white;
final containerColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
final searchColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
final laserLineColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
final titleAndIconColor = isDarkMode ? Colors.yellow : Colors.white;
