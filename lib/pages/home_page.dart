import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        width: 200,
        backgroundColor: Color(0xff107163),
        child: MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff107163),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
