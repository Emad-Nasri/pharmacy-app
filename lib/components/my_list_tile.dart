import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.title,
    required this.icon,
    this.page,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Widget? page;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      onTap: onTap ??
          () {
            if (page != null) Get.off(page!);
          },
      leading: Icon(
        icon,
        color: isDarkMode ? Colors.yellow : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: isDarkMode ? Colors.yellow : Colors.white),
      ),
    );
  }
}
