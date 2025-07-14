import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_invoice.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/models/date.dart';
import 'package:pharmacy_app/pages/invoice_page.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    required this.productName,
    required this.description,
    required this.price,
    required this.useage,
    required this.quantity,
    required this.endD,
    required this.endM,
    required this.endY,
    required this.startD,
    required this.startM,
    required this.startY,
  });

  final String productName;
  final String description;
  final String useage;
  final double price;
  final int? quantity;
  final int startD;
  final int startM;
  final int startY;
  final int endD;
  final int endM;
  final int endY;
  @override
  Widget build(BuildContext context) {
    Date date = Date(date: '', day: 0, month: 0, year: 0);
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final textColor = isDarkMode ? Colors.yellow : Colors.black;
    final appBarTextColor = isDarkMode ? Colors.yellow : Colors.white;
    final backgroundColor = Theme.of(context).colorScheme.surface;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final tabBarColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: iconColor),
          backgroundColor: appBarColor,
          title: Text(
            S.of(context).details,
            style: TextStyle(color: appBarTextColor),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.date_range,
                color: iconColor,
              ),
              onPressed: () {
                Get.off(const InvoicePage());
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بيانات المنتج
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product name: $productName',
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Usage: $useage',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: $price \$',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final invoiceController = Get.find<InvoiceController>();
                      invoiceController.addMedicine(
                        MyMedicine(
                          medName: productName,
                          price: price,
                          quantity: 1,
                          image: '',
                          description: description,
                          useage: useage,
                          startD: startD,
                          startM: startM,
                          startY: startY,
                          endD: endD,
                          endM: endM,
                          endY: endY,
                        ),
                      );
                      Get.snackbar("Success", "$productName added to invoice");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: textColor),
                              Text('Add to invoice',
                                  style: TextStyle(color: textColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // شريط التبويبات
            TabBar(
              labelColor: tabBarColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: tabBarColor,
              tabs: const [
                Tab(icon: Icon(Icons.remove_red_eye), text: 'Overview'),
                Tab(icon: Icon(Icons.local_offer), text: 'Details'),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product name : $productName',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Price : $price \$',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Manufacturing date : ${date.day = startD}-${date.month = startM}-${date.year = startY}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ُExpiration date : ${date.day = endD}-${date.month = endM}-${date.year = endY}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ُQuantity : $quantity',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
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
