import 'package:get/get.dart';
import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:pharmacy_app/models/medicine_model.dart';

/// نستخدم نفس الموديل لأن الحقول نفسها، لكن نُظهر العناصر التي **ليست دواء**
class ProductCategoryController extends GetxController {
  ProductCategoryController({required this.catName, this.endpoint = 'Product'});
  final String catName;
  final String endpoint;

  final products = <MedicineModel>[].obs; // عناصر بدون medicineResponse
  final isLoading = false.obs;
  final error = RxnString();

  bool _isPlainProduct(dynamic m) {
    if (m == null) return true; // null => منتج عادي
    if (m is Map) return m.isEmpty; // كائن فاضي
    if (m is List) return m.isEmpty; // مصفوفة فاضية
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      error.value = null;

      final res = await HttpHelper.get(endpoint);
      final list = (res is List) ? res : (res is Map ? [res] : <dynamic>[]);

      final parsed = list
          .where((e) => _isPlainProduct(e['medicineResponse'])) // منتجات فقط
          .map((e) => MedicineModel.fromJson(e))
          .where((p) =>
              (p.categoryName ?? '').toLowerCase() == catName.toLowerCase())
          .toList();

      products.assignAll(parsed);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'تعذّر تحميل المنتجات');
    } finally {
      isLoading.value = false;
    }
  }
}
