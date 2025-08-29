import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/components/my_invoice.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/helpers/utils.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final InvoiceController invoiceController = Get.find();

    final isDarkMode = themeController.theme == ThemeMode.dark;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;
    final boxDecorationColor =
        isDarkMode ? Colors.grey.shade800 : const Color(0xff107163);
    final textColor = isDarkMode ? Colors.yellow : Colors.black;
    final borderColor = isDarkMode ? Colors.yellow : Colors.black;

    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      drawer: const Drawer(width: 200, child: MyDrawer()),
      appBar: AppBar(
        title: Text(
          S.of(context).invoice,
          style: TextStyle(color: iconColor),
        ),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شعار
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // تاريخ الفاتورة
            Text("${S.of(context).invoiceDate}: $formattedDate",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            // رؤوس الجدول
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).medicine,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(S.of(context).price,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(S.of(context).quantity,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(S.of(context).total,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(color: Colors.black),

            // قائمة المنتجات
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: invoiceController.items.length,
                    itemBuilder: (context, index) {
                      final item = invoiceController.items[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // الاسم
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                initialValue: item.name,
                                onChanged: (value) => item.name = value.trim(),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // السعر
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                initialValue: item.price.toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // الكمية
                            Expanded(
                              child: TextFormField(
                                initialValue: item.quantity.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  item.quantity =
                                      int.tryParse(value) ?? item.quantity;
                                  invoiceController.items.refresh();
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // الإجمالي
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.total.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ),

            const SizedBox(height: 10),

            // الإجمالي النهائي
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${S.of(context).total}: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Obx(() => Text(
                      "${invoiceController.total.toStringAsFixed(2)} \$",
                      style: TextStyle(fontSize: 18, color: textColor),
                    )),
              ],
            ),

            const SizedBox(height: 20),

            // زر الطباعة
            GestureDetector(
              onTap: () {
                final filteredItems = invoiceController.items
                    .where((item) => item.name.trim().isNotEmpty)
                    .toList();

                if (filteredItems.isEmpty) {
                  Get.snackbar("خطأ", "لا يوجد عناصر صالحة للطباعة");
                  return;
                }

                printPdf(filteredItems);
              },
              child: Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                  color: boxDecorationColor,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      S.of(context).printInvoice,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
