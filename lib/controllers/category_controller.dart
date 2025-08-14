import 'package:get/get.dart';
import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:pharmacy_app/models/category_model.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      final List data = await HttpHelper.get('ProductCategory');
      print("API Response: $data");

      categories.value = data
          .map((e) => CategoryModel.fromJson(e))
          .where((c) => c.id != 0) // تجاهل الفاضي أو الغلط
          .toList();
    } catch (e) {
      print("FetchCategories Error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }
}
