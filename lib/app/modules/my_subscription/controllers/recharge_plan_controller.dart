import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargePlanController extends GetxController {
  final RxInt selectedPaymentIndex =
      (-1).obs; // -1 means no selection initially
  final RxList<Map<String, dynamic>> priceDetails =
      [
        {
          "title": "Item Total",
          "price": "₹3099",
          "discountedPrice": "₹1379",
          "isStrikethrough": true,
        },
        {"title": "MRP", "price": "₹3098"},
        {"title": "Product Discount", "price": "₹1750", "color": "#2196F3"},
        {"title": "Promotional Discount", "price": "₹35"},
        {"title": "Additional Discount", "price": "₹35"},
        {"title": "Delivery fee 3.7 KM", "price": "₹35"},
        {"title": "Handling Charges", "price": "₹15"},
      ].obs;

  final RxList<Map<String, dynamic>> addedItems =
      [
        {
          'productname': 'Bombay Shaving Company\nNoir Deodorant Spray',
          'productPrice': '220',
          'hasGift': true,
        },
        {
          'productname': 'Sample Product\nItem Two',
          'productPrice': '150',
          'hasGift': false,
        },
      ].obs;

  final RxList<int> quantities = [1, 1].obs;

  final RxString totalPrice = '0'.obs;
  final RxString totalSavings = '0'.obs;
  final RxString deliveryFeeSaving = '35'.obs; // Assuming delivery fee is saved

  @override
  void onInit() {
    super.onInit();
    updateCalculations();
    // Listen for changes in priceDetails or addedItems
    ever(priceDetails, (_) => updateCalculations());
    ever(addedItems, (_) => updateCalculations());
    ever(quantities, (_) => updateCalculations());
  }

  void selectPaymentMethod(int index) {
    selectedPaymentIndex.value = index;
  }

  void updateCalculations() {
    // Calculate total price from priceDetails
    double total = 0;
    for (var item in priceDetails) {
      if (item.containsKey("discountedPrice")) {
        final price =
            double.tryParse(item["discountedPrice"].replaceAll('₹', '')) ?? 0;
        total += price;
      } else if (item["title"] != "Item Total") {
        final price = double.tryParse(item["price"].replaceAll('₹', '')) ?? 0;
        total += price;
      }
    }
    // Optionally include addedItems if needed
    // double itemsTotal = 0;
    // for (int i = 0; i < addedItems.length; i++) {
    //   final price = double.tryParse(addedItems[i]['productPrice'] ?? '0') ?? 0;
    //   final quantity = quantities[i];
    //   itemsTotal += price * quantity;
    // }
    // total += itemsTotal;
    totalPrice.value = total.toStringAsFixed(0);

    // Calculate total savings
    double savings = 0;
    for (var item in priceDetails) {
      if (item["title"] == "Item Total" &&
          item.containsKey("discountedPrice")) {
        final original =
            double.tryParse(item["price"].replaceAll('₹', '')) ?? 0;
        final discounted =
            double.tryParse(item["discountedPrice"].replaceAll('₹', '')) ?? 0;
        savings += original - discounted;
      } else if (item["title"].contains("Discount")) {
        final discount =
            double.tryParse(item["price"].replaceAll('₹', '')) ?? 0;
        savings += discount;
      }
    }
    totalSavings.value = savings.toStringAsFixed(0);
  }

  List<Map<String, dynamic>> paymentMethod = [
    {'icon': Icons.account_balance, 'type': 'Bank Transfer'},
    {'icon': Icons.credit_card, 'type': 'Card Payment'},
    {'icon': Icons.qr_code, 'type': 'UPI-QR'}, // Fixed: 'upi_pay' is incorrect
    {'icon': Icons.account_balance_wallet, 'type': 'Wallet Transfer'},
    {'icon': Icons.payments, 'type': 'Cash'},
  ];
  var selectedPaymentmethodIndex = Rx<int?>(null);
  void toggleSelection(int index) {
    if (selectedPaymentmethodIndex.value == index) {
      // If the same item is tapped, deselect it
      selectedPaymentmethodIndex.value = null;
    } else {
      // Select the new item
      selectedPaymentmethodIndex.value = index;
    }
  }

  var checkBoxList = List.generate(5, (index) => false.obs).obs;

  void toggleCheckbox(int index, bool value) {
    checkBoxList[index].value = value;
  }
}
