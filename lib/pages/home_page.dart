import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_category.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Drawer(
        width: 200,
        backgroundColor: Color(0xff107163),
        child: MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          'Home',
          style: TextStyle(color: iconColor),
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.wb_sunny, color: iconColor),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 3.5,
              children: const [
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
                MyCategory(catName: 'Headache', image: 'logo.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
