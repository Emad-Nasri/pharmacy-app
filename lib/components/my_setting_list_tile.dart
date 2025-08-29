import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_text_field.dart';

// ignore: must_be_immutable
class MySettingListTile extends StatelessWidget {
  MySettingListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});
  IconData icon;
  String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
        leading: Icon(
          icon,
          color: isDarkMode ? const Color(0xff107163) : Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: isDarkMode ? const Color(0xff107163) : Colors.black),
        ),
        trailing: Icon(
          // الأيقونة على اليمين وتشير لليمين
          isArabic() ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
          color: isDarkMode ? const Color(0xff107163) : Colors.black,
        ),
        onTap: onTap);
  }
}
