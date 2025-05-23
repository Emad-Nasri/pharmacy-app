import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/components/my_list_tile.dart';
import 'package:pharmacy_app/pages/home_page.dart';
import 'package:pharmacy_app/pages/login.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<String> allItems = [
    'Panadol',
    'Amoxicillin',
    'Aspirin',
    'Vitamin C',
    'Ibuprofen',
    'Insulin',
    'Paracetamol',
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterSearch(String query) {
    final results = allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
          backgroundColor: const Color(0xff107163), child: MyDrawer()),
      appBar: AppBar(
        backgroundColor: const Color(0xff107163),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // search bar
            TextField(
              controller: searchController,
              onChanged: filterSearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color(0xff107163)),
                hintText: 'Search for a medicine...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // results list
            Expanded(
              child: filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(filteredItems[index]),
                            leading: const Icon(Icons.medication_outlined),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // تفاصيل الدواء (اختياري)
                            },
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No results found.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
