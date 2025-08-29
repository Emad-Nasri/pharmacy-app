import 'package:get/get.dart';
import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:pharmacy_app/models/medicine_model.dart';

/// يعرض عناصر "منتجات" فقط (غير أدوية).
/// في حال الـ API يرجع كل العناصر كدواء، منعمل fallback ونعرِض حسب التصنيف بدل ما نخليها فاضية.
class ProductCategoryController extends GetxController {
  ProductCategoryController({required this.catName, this.endpoint = 'Product'});
  final String catName;
  final String endpoint;

  final products = <MedicineModel>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  bool _isMedicine(dynamic mr) {
    if (mr == null) return false;
    if (mr is Map && mr.isEmpty) return false;
    if (mr is! Map) return false;

    final manufacturer =
        (mr['manufacturer'] ?? '').toString().trim().isNotEmpty;
    final activeIngredient =
        (mr['activeIngredient'] ?? '').toString().trim().isNotEmpty;
    final hasRx = mr['isRequiredDescription'] != null;

    // لو أي حقل من هدول موجود اعتبره دواء
    return manufacturer || activeIngredient || hasRx;
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

      // فلترة حسب التصنيف أولاً
      final byCat = list.where((e) {
        final cat = (e['categoryName'] ?? '').toString();
        return cat.toLowerCase() == catName.toLowerCase();
      }).toList();

      // استبعاد الأدوية
      final nonMedRaw =
          byCat.where((e) => !_isMedicine(e['medicineResponse'])).toList();

      // لو ما طلع شي بعد الاستبعاد (لأن الـ API يرجعها كلها كدواء) اعرض byCat كـ fallback
      final chosen = nonMedRaw.isNotEmpty ? nonMedRaw : byCat;

      final parsed = chosen.map((e) => MedicineModel.fromJson(e)).toList();

      products.assignAll(parsed);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'تعذّر تحميل المنتجات');
    } finally {
      isLoading.value = false;
    }
  }
}
