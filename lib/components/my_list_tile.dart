import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key, required this.title, required this.icon, required this.page});

  final String title;
  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.to(page),
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
