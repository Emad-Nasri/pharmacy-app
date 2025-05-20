import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_list_tile.dart';
import 'package:pharmacy_app/pages/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: const Color(0xff107163),
        child: ListView(
          children: const [
            MyListTile(
              title: 'Home',
              icon: Icons.home,
              page: HomePage(),
            ),
            MyListTile(
              title: 'Logout',
              icon: Icons.logout,
              page: LoginPage(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff107163),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
