import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme =>
      _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  void saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void toggleTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!_loadThemeFromBox());
  }
}
