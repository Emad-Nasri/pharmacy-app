import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/generated/l10n.dart';

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final textColor = isDarkMode ? Colors.yellow : Colors.white;
    final iconColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
    final searchColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
    final menuColor = isDarkMode ? Colors.yellow : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const Drawer(
        width: 200,
        child: MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: menuColor),
        title: Text(
          S.of(context).search,
          style: TextStyle(color: textColor),
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
                prefixIcon: Icon(Icons.search, color: iconColor),
                label: Text(S.of(context).search,
                    style: TextStyle(color: searchColor)),
                hintText: S.of(context).search1, //search for a product...
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.yellow : const Color(0xff107163),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.yellow : const Color(0xff107163),
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: isDarkMode ? Colors.grey[850] : Colors.white,
                filled: true,
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
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.white,
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
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
                            const SizedBox(height: 10),
                            Text(
                              S.of(context).no_result,
                              style: const TextStyle(fontSize: 16),
                            ),
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
