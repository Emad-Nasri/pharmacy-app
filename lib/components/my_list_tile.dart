import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  MyListTile({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
