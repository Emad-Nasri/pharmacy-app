import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/models/invoice_item.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final List<InvoiceItem> _items = [
    InvoiceItem(name: 'Panadol', price: 5.0, quantity: 2),
  ];

  final DateTime invoiceDate = DateTime.now();

  void _addNewRow() {
    setState(() {
      _items.add(InvoiceItem(name: '', price: 0, quantity: 1));
    });
  }

  double _calculateTotal() {
    return _items.fold(0, (sum, item) => sum + item.total);
  }

  Future<void> _printPdf() async {
    final pdf = pw.Document();
    final imageLogo =
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Image(pw.MemoryImage(imageLogo), height: 100),
            pw.SizedBox(height: 10),
            pw.Text(
                'Invoice Date: ${DateFormat('yyyy-MM-dd').format(invoiceDate)}',
                style: const pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('No.',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Medicine',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Price',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Quantity',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                ..._items.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final item = entry.value;
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(index.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(item.name),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${item.price.toStringAsFixed(2)}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${item.quantity}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${item.total.toStringAsFixed(2)}'),
                      ),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 15),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text('Total: ',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 14)),
                pw.Text('${_calculateTotal().toStringAsFixed(2)} \$',
                    style: const pw.TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

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

    final formattedDate = DateFormat('yyyy-MM-dd').format(invoiceDate);

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
                            initialValue: item.name,
                            onChanged: (value) =>
                                setState(() => item.name = value),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        // Price
                        Expanded(
                          child: TextFormField(
                            initialValue: item.price.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(
                                () => item.price = double.tryParse(value) ?? 0),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        // Quantity
                        Expanded(
                          child: TextFormField(
                            initialValue: item.quantity.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(
                                () => item.quantity = int.tryParse(value) ?? 1),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        // Total
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.total.toStringAsFixed(2)),
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
                  "${_calculateTotal().toStringAsFixed(2)} \$",
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _addNewRow,
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
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text("Add Row",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _printPdf,
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
