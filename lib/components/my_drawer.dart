import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_list_tile.dart';
import 'package:pharmacy_app/pages/home_page.dart';
import 'package:pharmacy_app/pages/login.dart';
import 'package:pharmacy_app/pages/search_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MyListTile(
          title: 'Home',
          icon: Icons.home_outlined,
          page: HomePage(),
        ),
        MyListTile(
          title: 'Search',
          icon: Icons.search,
          page: SearchPage(),
        ),
        MyListTile(
          title: 'Logout',
          icon: Icons.logout,
          page: LoginPage(),
        ),
      ],
    );
  }
}
