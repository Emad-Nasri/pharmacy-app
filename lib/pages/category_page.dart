import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/my_medicine.dart';
import 'package:pharmacy_app/variabels/theme_color.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.catName});
  final String catName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        title: Text(
          catName,
          style: TextStyle(color: iconColor),
        ),
      ),
      body: ListView(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 3.5,
            children: [
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
              MyMedicine(
                image: 'panadol.jpg',
                medName: 'Panadol',
                price: 25,
                description:
                    'What is paracetamol?Paracetamol (Panadol, Calpol, Alvedon) is an analgesic and antipyretic drug that is used to temporarily relieve mild-to-moderate pain and fever. It is commonly included as an ingredient in cold and flu medications and is also used on its own.Paracetamol is exactly the same drug as acetaminophen (Tylenol). Paracetamol is the drug\'s name assigned using the International Nonproprietary Name (INN) generic name system. Paracetamol is the name used for the drug in places such as Europe, Australia, New Zealand and India. Acetaminophen is the generic name assigned using the United States Adopted Names (USAN) system. Acetaminophen is the name used in countries such as the US, Canada and Japan. Usually the INN and USAN generic names for a drug are the same and don\'t differ between countries.It is not clear exactly how paracetamol works. However, it is thought to work by blocking chemical messengers in the brain that let us know when we\'re in pain and by affecting the chemical messengers that regulate our body temperature. The evidence suggests that paracetamol inhibits the production of prostaglandins, which are made by the body to deal with illness and injury. It\'s also thought to act on the serotonergic, opioid, nitric oxide and cannabinoid pathways.',
                useage:
                    'Headache ,Tension headache,Migraine,Backache,Rheumatic and muscle pain,Mild arthritis/osteoarthritis,Toothache',
                quantity: 20,
                startD: 10,
                startM: 10,
                startY: 2024,
                endD: 9,
                endM: 10,
                endY: 2025,
                barcode: '6213960002111',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
