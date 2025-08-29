import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/controllers/medicine_category_controller.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class MedicineCategoryPage extends StatelessWidget {
  const MedicineCategoryPage({super.key, required this.catName});
  final String catName;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDarkMode = themeController.theme == ThemeMode.dark;

    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final iconColor = isDarkMode ? Colors.yellow : Colors.white;

    // اربط الكونترولر – يجلب فقط الأدوية الخاصة بهذه الفئة
    final MedicineController c = Get.put(MedicineController(catName: catName));

    // حالة بحث محلي
    final RxString query = ''.obs;

    int crossAxisCountForWidth(double w) {
      if (w >= 1000) return 4;
      if (w >= 700) return 3;
      return 2;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(catName, style: TextStyle(color: iconColor)),
        actions: [
          IconButton(
            onPressed: () => c.fetchMedicines(),
            icon: Icon(Icons.refresh, color: iconColor),
            tooltip: 'تحديث',
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (c.error.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'حدث خطأ:\n${c.error.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDarkMode ? Colors.yellow : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => c.fetchMedicines(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        }

        // تطبيق البحث المحلي
        final list = query.value.trim().isEmpty
            ? c.medicines
            : c.medicines.where((m) {
                final q = query.value.toLowerCase();
                return m.name.toLowerCase().contains(q) ||
                    (m.description ?? '').toLowerCase().contains(q) ||
                    (m.medicineDetails.activeIngredient ?? '')
                        .toLowerCase()
                        .contains(q) ||
                    (m.medicineDetails.manufacturer ?? '')
                        .toLowerCase()
                        .contains(q);
              }).toList();

        if (list.isEmpty) {
          return const Center(child: Text('لا توجد عناصر'));
        }

        return RefreshIndicator(
          onRefresh: () => c.fetchMedicines(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cols = crossAxisCountForWidth(constraints.maxWidth);
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // حقل بحث
                  Obx(() => TextField(
                        onChanged: (v) => query.value = v,
                        decoration: InputDecoration(
                          hintText: 'ابحث عن دواء...',
                          prefixIcon: const Icon(Icons.search),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),

                  // الشبكة
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 3.5,
                    ),
                    itemBuilder: (_, i) {
                      final m = list[i];

                      // نص تجميعي من تفاصيل الدواء
                      final usage = [
                        if ((m.medicineDetails.activeIngredient ?? '')
                            .isNotEmpty)
                          'Active: ${m.medicineDetails.activeIngredient}',
                        if ((m.medicineDetails.manufacturer ?? '').isNotEmpty)
                          'Mfr: ${m.medicineDetails.manufacturer}',
                      ].join(' • ');

                      // إن لم تكن لديك صور، ضع صورة افتراضية هنا
                      final imageGuess =
                          '${m.name.toLowerCase().replaceAll(" ", "")}.jpg';

                      return MyMedicine(
                        image: imageGuess,
                        medName: m.name,
                        price: (m.sellPrice ?? 0).toDouble(),
                        description: m.description ?? '',
                        useage: usage,
                        quantity: m.minimumStockLevel ?? 0,
                        startD: 1,
                        startM: 1,
                        startY: 2024,
                        endD: 1,
                        endM: 1,
                        endY: 2026,
                        barcode: '',
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
