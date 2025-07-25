import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/components/my_setting_list_tile.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final appBarTextColor = isDarkMode ? Colors.yellow : Colors.white;
    final settingColor =
        isDarkMode ? Colors.yellow : const Color.fromARGB(255, 177, 170, 170);
    final menuColor = isDarkMode ? Colors.yellow : Colors.white;
    final textColor = isDarkMode ? Colors.yellow : Colors.black;
    final iconColor = isDarkMode ? Colors.yellow : Colors.black;
    final containerColor = isDarkMode ? Colors.grey.shade900 : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const Drawer(
        width: 200,
        child: MyDrawer(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: menuColor),
        backgroundColor: appBarColor,
        title: Text(
          S.of(context).setting,
          style: TextStyle(color: appBarTextColor),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 10, bottom: 10),
            child: Text(
              S.of(context).setting,
              style: TextStyle(color: settingColor, fontSize: 20),
            ),
          ),
          MySettingListTile(
            icon: Icons.language,
            title: S.of(context).change_lang,
            onTap: () {
              Get.bottomSheet(
                Container(
                  color: containerColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: iconColor,
                        ),
                        title: Text(
                          S.of(context).english,
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          print(
                              'Tapped on change language to ${S.of(context).english}');
                          Get.updateLocale(const Locale('en', 'US'));
                          GetStorage().write("lang", 'en');
                          Get.back();
                        },
                      ),
                      const Divider(
                        color: Color(0xFF6C8090),
                        thickness: 2,
                        indent: 60,
                        endIndent: 60,
                        height: 15,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: iconColor,
                        ),
                        title: Text(
                          S.of(context).arabic,
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          print(
                              'Tapped on change language to ${S.of(context).arabic}');
                          Get.updateLocale(const Locale('ar', 'SY'));
                          GetStorage().write("lang", 'ar');
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          MySettingListTile(
            icon: Icons.brightness_6,
            title: S.of(context).change_mode,
            onTap: () {
              print('Tapped on change mode to ${S.of(context).change_mode}');
              final themeController = Get.find<ThemeController>();

              Get.bottomSheet(
                Container(
                  color: containerColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.light_mode,
                          color: iconColor,
                        ),
                        title: Text(
                          S.of(context).light,
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          print(
                              'Tapped on change mode to ${S.of(context).light}');
                          Get.changeThemeMode(ThemeMode.light);
                          themeController
                              .saveThemeToBox(false); // false = light
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.dark_mode,
                          color: iconColor,
                        ),
                        title: Text(
                          S.of(context).night,
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          print('Tapped on  ${S.of(context).night}');
                          Get.changeThemeMode(ThemeMode.dark);
                          themeController.saveThemeToBox(true); // true = dark
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 10, bottom: 10),
            child: Text(
              S.of(context).other,
              style: TextStyle(color: settingColor, fontSize: 20),
            ),
          ),
          MySettingListTile(
            icon: Icons.star_border_outlined,
            title: S.of(context).evaluation,
            onTap: () {
              print('Tapped on dark ${S.of(context).evaluation}');
            },
          ),
          const Divider(
            color: Color(0xFF6C8090),
            thickness: 2,
            indent: 60,
            endIndent: 60,
            height: 15,
          ),
          MySettingListTile(
            icon: Icons.share_outlined,
            title: S.of(context).share,
            onTap: () {
              print('Tapped on ${S.of(context).share}');
            },
          ),
          const Divider(
            color: Color(0xFF6C8090),
            thickness: 2,
            indent: 60,
            endIndent: 60,
            height: 15,
          ),
          MySettingListTile(
            icon: Icons.message_outlined,
            title: S.of(context).support,
            onTap: () {
              print('Tapped on ${S.of(context).support}');
            },
          ),
        ],
      ),
    );
  }
}
