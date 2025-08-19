import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/my_drawer.dart';
import 'package:pharmacy_app/components/my_expiration.dart';
import 'package:pharmacy_app/components/my_text_field.dart';
import 'package:pharmacy_app/generated/l10n.dart';
import 'package:pharmacy_app/variabels/theme_color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
    this.image,
    this.medName,
    this.description,
    this.useage,
    this.price,
    this.quantity,
    this.startD,
    this.startM,
    this.startY,
    this.endD,
    this.endM,
    this.endY,
  });

  final String? image;
  final String? medName;
  final String? description;
  final String? useage;
  final double? price;
  final int? quantity;
  final int? startD;
  final int? startM;
  final int? startY;
  final int? endD;
  final int? endM;
  final int? endY;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const Drawer(
        width: 200,
        child: MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          S.of(context).notifications,
          style: TextStyle(color: iconColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: boxDecorationColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  S.of(context).expiration_date_med,
                  style: TextStyle(color: textColor),
                ),
                trailing: Icon(
                  // الأيقونة على اليمين وتشير لليمين
                  isArabic()
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  color: textColor,
                ),
                onTap: () {
                  Get.to(() => MyExpiration(
                        image: image,
                        medName: medName,
                        description: description,
                        useage: useage,
                        price: price,
                        quantity: quantity,
                        startD: startD,
                        startM: startM,
                        startY: startY,
                        endD: endD,
                        endM: endM,
                        endY: endY,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
