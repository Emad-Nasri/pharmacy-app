import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_drawer.dart';

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

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredItems = [];
      });
    } else {
      final results = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        filteredItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const Drawer(
        backgroundColor: Color(0xff107163),
        child: MyDrawer(),
      ),
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
                label: const Text('Search',
                    style: TextStyle(color: Color(0xff107163))),
                hintText: 'Search for a medicine...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // results grid
            Expanded(
              child: searchController.text.isNotEmpty
                  ? filteredItems.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 3 / 2,
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('Tapped on ${filteredItems[index]}');
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.medication_outlined,
                                        size: 40, color: Color(0xff107163)),
                                    const SizedBox(height: 10),
                                    Text(
                                      filteredItems[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/sad.png'),
                                ),
                              ),
                            ),
                            const Text('No results found.'),
                          ],
                        ))
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
