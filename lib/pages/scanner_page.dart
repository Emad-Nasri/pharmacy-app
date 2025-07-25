import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/theme/theme_controller.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage>
    with SingleTickerProviderStateMixin {
  String barcodeResult = ''; // رح نعين قيمتها لاحقاً داخل initState/build
  bool isTorchOn = false;
  final MobileScannerController cameraController = MobileScannerController();

  late AnimationController _animationController;
  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();

    // تعيين النص الافتراضي بعد ما يصير عندنا Context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        barcodeResult = S.of(context).not_yet_scanned;
      });
    });

    // أنيميشن لخط الليزر
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
      cameraController.toggleTorch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeController.theme == ThemeMode.dark;
    final appBarColor =
        isDarkMode ? Colors.grey.shade900 : const Color(0xff107163);
    final laserLineColor = isDarkMode ? Colors.yellow : const Color(0xff107163);
    final titleAndIconColor = isDarkMode ? Colors.yellow : Colors.white;

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
          // الكاميرا
          MobileScanner(
            controller: cameraController,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String code =
                    barcodes.first.rawValue ?? S.of(context).unknown;
                setState(() {
                  barcodeResult = code;
                });
              }
            },
          ),

          // الإطار مع خط الليزر
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

          // النتيجة أسفل الشاشة
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
