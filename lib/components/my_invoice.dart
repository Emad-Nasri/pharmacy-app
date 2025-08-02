import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/models/invoice_item.dart';

class InvoiceController extends GetxController {
  var items = <InvoiceItem>[].obs;

  void addMedicine(MyMedicine medicine) {
    final existingIndex =
        items.indexWhere((item) => item.name == medicine.medName);

    if (existingIndex != -1) {
      items[existingIndex].quantity += 1;
    } else {
      items.add(
        InvoiceItem(
          name: medicine.medName,
          price: medicine.price,
          quantity: 1,
        ),
      );
    }
  }

  double get total => items.fold(0, (sum, item) => sum + item.total);

  void clearInvoice() {
    items.clear();
  }
}
