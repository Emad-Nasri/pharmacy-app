import 'package:get/get.dart';
import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:pharmacy_app/models/medicine_model.dart';

class MedicineController extends GetxController {
  MedicineController({
    required this.catName,
    this.endpoint = 'Medicine', // مثال: GET /api/Medicine
  });

  final String catName;
  final String endpoint;

  final medicines = <MedicineModel>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      error.value = null;

      final res = await HttpHelper.get(endpoint);
      final list = (res is List)
          ? res
          : (res is Map<String, dynamic>)
              ? [res]
              : <dynamic>[];

      final parsed = list
          .map((e) => MedicineModel.fromJson(Map<String, dynamic>.from(e)))
          // نعرض فقط الأدوية، و نفلترها حسب اسم التصنيف الظاهر في AppBar
          .where((m) =>
              (m.medicineDetails.productResponse.productId !=
                  0) && // لديه payload
              (m.categoryName ?? '').toLowerCase() == catName.toLowerCase())
          .toList();

      medicines.assignAll(parsed);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'تعذّر تحميل الأدوية');
    } finally {
      isLoading.value = false;
    }
  }
}
