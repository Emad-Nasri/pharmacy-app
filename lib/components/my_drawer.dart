import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_list_tile.dart';
import 'package:pharmacy_app/pages/home_page.dart';
import 'package:pharmacy_app/pages/invoice_page.dart';
import 'package:pharmacy_app/pages/login.dart';
import 'package:pharmacy_app/pages/notification_page.dart';
import 'package:pharmacy_app/pages/search_page.dart';
import 'package:pharmacy_app/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode ? Colors.grey.shade900 : const Color(0xff107163),
      child: ListView(
        children: [
          const MyListTile(
            title: 'Home',
            icon: Icons.home_outlined,
            page: HomePage(),
          ),
          const MyListTile(
            title: 'Search',
            icon: Icons.search,
            page: SearchPage(),
          ),
          const MyListTile(
            title: 'Notifications',
            icon: Icons.notifications_none_outlined,
            page: NotificationPage(),
          ),
          const MyListTile(
            title: 'Invoice',
            icon: Icons.date_range,
            page: InvoicePage(),
          ),
          MyListTile(
            title: 'Logout',
            icon: Icons.logout,
            onTap: () async {
              print('ggg');
              await AuthService.logout();
              print('ggg2');
              Get.offAll(() => const LoginPage());
              print('ggg3');
            },
          ),
        ],
      ),
    );
  }
}
