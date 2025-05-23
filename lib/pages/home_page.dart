import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_category.dart';
import 'package:pharmacy_app/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // GridView داخل SizedBox ليأخذ حجم محدد
            SizedBox(
              height: 1000,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
                children: const [
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                  MyCategory(
                    catName: 'Headche',
                    image: 'logo.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
