import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:pharmacy_app/helpers/utils.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final List<MyMedicine> _items = [];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;
    final boxDecorationColor =
        isDarkMode ? Colors.grey.shade800 : const Color(0xff107163);
    final textColor = isDarkMode ? Colors.yellow : Colors.black;
    final borderColor = isDarkMode ? Colors.yellow : Colors.black;

    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return Scaffold(
      drawer: const Drawer(
        width: 200,
        child: MyDrawer(),
      ),
      appBar: AppBar(
        title: Text(
          "Invoice",
          style: TextStyle(color: iconColor),
        ),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            Text("Invoice Date: $formattedDate",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Medicine', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(color: Colors.black),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        // Medicine name
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: item.medName,
                            onChanged: (value) => setState(() => item.medName),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        // Price
                        Expanded(
                          child: TextFormField(
                            initialValue: item.price.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() => item.price),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        // Quantity
                        Expanded(
                          child: TextFormField(
                            initialValue: item.quantity.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() => item.quantity),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        // Total
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text((item.price * item.quantity).toString()),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Total: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                Text(
                  "${calculateTotal(_items).toStringAsFixed(2)} \$",
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => printPdf(_items),
              child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: boxDecorationColor,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      ),
                      Text("Print Invoice",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  )),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
