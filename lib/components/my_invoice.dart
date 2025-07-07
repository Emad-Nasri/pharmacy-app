import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_medicine.dart';

class InvoiceController extends GetxController {
  var items = <MyMedicine>[].obs;

  void addMedicine(MyMedicine medicine) {
    items.add(medicine);
  }

  double get total =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
