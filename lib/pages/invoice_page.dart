// lib/pages/invoice_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/components/my_invoice.dart'; // InvoiceController
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/helpers/utils.dart'; // printPdf
import 'package:pharmacy_app/theme/theme_controller.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final invoiceController = Get.find<InvoiceController>();

    final isDark = themeController.theme == ThemeMode.dark;
    final appBarColor = isDark ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = Colors.white;
    final textColor = isDark ? Colors.yellow : Colors.black;

    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      drawer: const Drawer(width: 200, child: MyDrawer()),
      appBar: AppBar(
        title: Text(S.of(context).invoice, style: TextStyle(color: iconColor)),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            onPressed: () async {
              await invoiceController.submitSale();
            },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              final filtered = invoiceController.items
                  .where((it) => it.name.trim().isNotEmpty)
                  .toList();
              if (filtered.isEmpty) {
                Get.snackbar('خطأ', 'لا يوجد عناصر صالحة للطباعة');
                return;
              }
              printPdf(filtered);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // الشعار
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

            // التاريخ
            Text(
              "${S.of(context).invoiceDate}: $formattedDate",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // رؤوس الأعمدة (نفس نسب الـ flex تحت)
            Row(
              children: const [
                Expanded(
                  flex: 6,
                  child: Text(
                    'دواء',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'السعر',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 8), // مسافة صغيرة بين السعر والكمية
                Expanded(
                  flex: 3,
                  child: Text(
                    'الكمية',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'المجموع',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 36), // مكان زر الحذف
              ],
            ),
            const Divider(color: Colors.black),

            // العناصر
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: invoiceController.items.length,
                  itemBuilder: (context, index) {
                    final item = invoiceController.items[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // الاسم — أكبر حصة — قص بنقاط
                          Expanded(
                            flex: 6,
                            child: Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),

                          // السعر
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.price.toStringAsFixed(2),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // الكمية +/-
                          Expanded(
                            flex: 3,
                            child: FittedBox(
                              // حتى على الشاشات الضيقة ما يصير overflow
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _qtyBtn(
                                    icon: Icons.remove,
                                    onTap: () =>
                                        invoiceController.decrement(index),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  _qtyBtn(
                                    icon: Icons.add,
                                    onTap: () =>
                                        invoiceController.increment(index),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // المجموع
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.total.toStringAsFixed(2),
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // زر الحذف قرب المجموع
                          SizedBox(
                            width: 36,
                            child: IconButton(
                              tooltip: 'حذف',
                              onPressed: () =>
                                  invoiceController.removeAt(index),
                              icon: const Icon(Icons.delete),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
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
                Obx(
                  () => Text(
                    "${invoiceController.total.toStringAsFixed(2)} \$",
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // تفريغ
            OutlinedButton.icon(
              onPressed: invoiceController.clearInvoice,
              icon: const Icon(Icons.clear_all),
              label: const Text('تفريغ الفاتورة'),
            ),
          ],
        ),
      ),
    );
  }

  // زر كمية صغير ومدمج
  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
      visualDensity: VisualDensity.compact,
    );
  }
}
