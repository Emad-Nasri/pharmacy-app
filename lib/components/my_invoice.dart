// controllers/invoice_controller.dart
import 'package:get/get.dart';
import 'package:pharmacy_app/models/invoice_item.dart';
import 'package:pharmacy_app/models/medicine_model.dart';
import 'package:pharmacy_app/components/my_medicine.dart'; // ✅ لإستقبال MyMedicine
import 'package:pharmacy_app/helpers/http_helper.dart';

class InvoiceController extends GetxController {
  final items = <InvoiceItem>[].obs;

  // إضافة من موديل API (المفضلة)
  void addByModel(MedicineModel m, {int qty = 1}) {
    final id = (m.productId);
    final idx = items.indexWhere((it) => it.productId == id);
    if (idx != -1) {
      items[idx].quantity += qty;
      items.refresh();
    } else {
      items.add(InvoiceItem(
        productId: id,
        name: m.name,
        price: (m.sellPrice ?? 0).toDouble(),
        quantity: qty,
      ));
    }
  }

  // إضافة من MyMedicine (توافق مع الكود القديم)
  void addMedicine(MyMedicine medicine, {int productId = 0}) {
    final idx = items.indexWhere((it) => it.name == medicine.medName);
    if (idx != -1) {
      items[idx].quantity += 1;
      items.refresh();
    } else {
      items.add(
        InvoiceItem(
          productId:
              productId, // إذا ما متوفر ID خلّيه 0 (رح ينحذف قبل الإرسال)
          name: medicine.medName,
          price: medicine.price,
          quantity: 1,
        ),
      );
    }
  }

  // إضافة يدوية (من أزرار أو أي مصدر خارجي)
  void addManual({
    required int productId,
    required String name,
    required double price,
    int qty = 1,
  }) {
    final idx = items.indexWhere((it) => it.productId == productId);
    if (idx != -1) {
      items[idx].quantity += qty;
      items.refresh();
    } else {
      items.add(InvoiceItem(
        productId: productId,
        name: name,
        price: price,
        quantity: qty,
      ));
    }
  }

  void increment(int index) {
    items[index].quantity += 1;
    items.refresh();
  }

  void decrement(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity -= 1;
      items.refresh();
    }
  }

  void removeAt(int index) => items.removeAt(index);
  void clearInvoice() => items.clear();
  double get total => items.fold(0.0, (sum, it) => sum + it.total);

  Map<String, dynamic> buildSaleBody({String employeeName = 'emad123'}) {
    return {
      'saleDate': DateTime.now().toUtc().toIso8601String(),
      'totalAmount': total,
      'employeeName': employeeName,
      'saleItems': items.map((e) => e.toSaleItemMap()).toList(),
    };
  }

  /// إرسال الفاتورة للسيرفر (نفس الكود السابق)
  Future<Map<String, dynamic>?> submitSale(
      {String employeeName = 'emad123'}) async {
    if (items.isEmpty) {
      Get.snackbar('تنبيه', 'لا يوجد عناصر في الفاتورة');
      return null;
    }
    final body = buildSaleBody(employeeName: employeeName);
    try {
      final res = await HttpHelper.post('Sale', body);
      Get.snackbar('تم', 'تم حفظ الفاتورة بنجاح');
      return res;
    } catch (e) {
      Get.snackbar('خطأ', e.toString());
      return null;
    }
  }
}
