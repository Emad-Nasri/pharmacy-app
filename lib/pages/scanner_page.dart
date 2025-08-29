import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy_app/components/my_invoice.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage>
    with SingleTickerProviderStateMixin {
  String barcodeResult = '';
  bool isTorchOn = false;
  final MobileScannerController cameraController = MobileScannerController();

  late AnimationController _animationController;
  final ThemeController themeController = Get.find();
  final InvoiceController invoiceController = Get.find();

  // قائمة الأدوية (مثال محلي)
  final List<MyMedicine> allMedicines = [
    MyMedicine(
      image: 'panadol.png',
      medName: 'Panadol',
      price: 5.0,
      description: 'مسكن ألم',
      useage: 'صداع وحمى',
      quantity: 10,
      startD: 1,
      startM: 1,
      startY: 2024,
      endD: 1,
      endM: 1,
      endY: 2026,
      barcode: '6213960002111',
    ),
    MyMedicine(
      image: 'amoxil.png',
      medName: 'Amoxil',
      price: 7.5,
      description: 'مضاد حيوي',
      useage: 'التهابات',
      quantity: 5,
      startD: 5,
      startM: 2,
      startY: 2024,
      endD: 5,
      endM: 2,
      endY: 2025,
      barcode: '0987654321',
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        barcodeResult = S.of(context).not_yet_scanned;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  void toggleTorch() {
    setState(() {
      isTorchOn = !isTorchOn;
    });
    cameraController.toggleTorch();
  }

  Future<void> handleBarcodeScan(String code) async {
    if (!mounted) return;

    setState(() {
      barcodeResult = code;
    });

    // إيقاف مؤقت
    await cameraController.stop();

    // ابحث يدويًا لأن firstWhereOrNull غير متاحة افتراضيًا
    MyMedicine? found;
    for (final m in allMedicines) {
      if ((m.barcode ?? '') == code) {
        found = m;
        break;
      }
    }

    if (!mounted) return;

    if (found != null) {
      // نستخدم دالة التوافق التي أضفناها في الكنترولر
      invoiceController.addMedicine(found);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${found.medName} ${S.of(context).added_to_invoice}'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).product_not_found),
          backgroundColor: Colors.red,
        ),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      await cameraController.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeController.theme == ThemeMode.dark;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final laserLineColor = const Color(0xff107163);
    final titleAndIconColor =
        isDarkMode ? const Color(0xff107163) : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: titleAndIconColor,
        title: Text(
          S.of(context).barcode_scanner,
          style: TextStyle(color: titleAndIconColor),
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: Icon(
              isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: titleAndIconColor,
            ),
            onPressed: toggleTorch,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (BarcodeCapture capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue ?? S.of(context).unknown;
                handleBarcodeScan(code);
              }
            },
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: laserLineColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Positioned(
                        top: 250 * _animationController.value,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          color: laserLineColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Text(
                '${S.of(context).result}: $barcodeResult',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
