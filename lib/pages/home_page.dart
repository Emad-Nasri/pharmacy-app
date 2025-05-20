import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        surfaceTintColor: Colors.black,
        backgroundColor: const Color(0xff107163),
        child: ListView(
          children: [MyListTile(title: 'Home', icon: Icons.home)],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff107163),
      ),
    );
  }
}
