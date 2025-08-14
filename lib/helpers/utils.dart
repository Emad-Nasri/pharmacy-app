import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pharmacy_app/models/invoice_item.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> printPdf(List<InvoiceItem> items) async {
  final pdf = pw.Document();

  final imageLogo =
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();

  final now = DateTime.now(); // ✅ صارت داخل الدالة

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Image(pw.MemoryImage(imageLogo), height: 100),
          pw.SizedBox(height: 10),
          pw.Text(
            'Invoice Date: ${DateFormat('yyyy-MM-dd').format(now)}',
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: [
                  _tableHeader('No.'),
                  _tableHeader('Medicine'),
                  _tableHeader('Price'),
                  _tableHeader('Quantity'),
                  _tableHeader('Total'),
                ],
              ),
              ...items.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final item = entry.value;
                return pw.TableRow(
                  children: [
                    _tableCell(index.toString()),
                    _tableCell(item.name),
                    _tableCell(item.price.toStringAsFixed(2)),
                    _tableCell(item.quantity.toString()),
                    _tableCell(item.total.toStringAsFixed(2)),
                  ],
                );
              }),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Total: ',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              pw.Text(
                '${calculateTotal(items).toStringAsFixed(2)} \$',
                style: const pw.TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

pw.Widget _tableHeader(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    ),
  );
}

pw.Widget _tableCell(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(text),
  );
}

double calculateTotal(List<InvoiceItem> items) {
  return items.fold(0, (sum, item) => sum + item.total);
}
