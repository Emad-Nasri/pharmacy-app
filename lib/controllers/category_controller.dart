import 'package:get/get.dart';
import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:pharmacy_app/models/category_model.dart';

class CategoryController extends GetxController {
  /// قائمتين منفصلتين
  var productCategories = <CategoryModel>[].obs;
  var medicineCategories = <CategoryModel>[].obs;

  var isLoading = false.obs;
  var error = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      error.value = null;

      // --- ProductCategory ---
      final List productData = await HttpHelper.get('ProductCategory');
      productCategories.value = productData
          .map((e) => CategoryModel.fromJson(e))
          .where((c) => c.id != 0)
          .toList();

      // --- MedicineCategory ---
      final List medicineData = await HttpHelper.get('MedicineCategory');
      medicineCategories.value = medicineData
          .map((e) => CategoryModel.fromJson(e))
          .where((c) => c.id != 0)
          .toList();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
