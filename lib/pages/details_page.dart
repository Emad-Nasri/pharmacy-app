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
    required this.barcode,
  });

  final String productName;
  final String description;
  final String useage;
  final String barcode;
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
    final date = Date(date: '', day: 0, month: 0, year: 0);
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final textColor = isDarkMode ? const Color(0xff107163) : Colors.black;
    final appBarTextColor = isDarkMode ? const Color(0xff107163) : Colors.white;
    final backgroundColor = Theme.of(context).colorScheme.surface;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final tabBarColor = isDarkMode ? const Color(0xff107163) : Colors.black;
    final iconColor = isDarkMode ? const Color(0xff107163) : Colors.white;

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
              icon: Icon(Icons.date_range, color: iconColor),
              onPressed: () => Get.off(const InvoicePage()),
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
                    '${S.of(context).product_name} : $productName',
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${S.of(context).usage} : $useage',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${S.of(context).price}: $price \$',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
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
                          barcode: barcode,
                        ),
                        // لو توفر لديك productId مرّره هنا
                        productId: 0,
                      );
                      Get.snackbar(
                        S.of(context).success,
                        "$productName ${S.of(context).added_to_invoice}",
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: textColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: textColor),
                              const SizedBox(width: 6),
                              Text(S.of(context).add_to_invoice,
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
              tabs: [
                Tab(
                    icon: const Icon(Icons.remove_red_eye),
                    text: S.of(context).overview),
                Tab(
                    icon: const Icon(Icons.local_offer),
                    text: S.of(context).details),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).product_name} : $productName',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${S.of(context).price} : $price \$',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${S.of(context).manufacturing_date} : ${date.day = startD}-${date.month = startM}-${date.year = startY}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ُ${S.of(context).expiration_date} : ${date.day = endD}-${date.month = endM}-${date.year = endY}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ُ${S.of(context).quantity} : ${quantity ?? 0}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          'ُ${S.of(context).bacode} : $barcode',
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
