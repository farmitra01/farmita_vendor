import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosCheckoutController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final count = 0.obs;
  var currentTabIndex = 0.obs;

  // First list: items added to the checkout
  var addedItems =
      <Map<String, dynamic>>[
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

  // Track added state and quantities for first list
  var isAdded = <bool>[true, true].obs;
  var quantities = <int>[1, 1].obs;

  // Second list: quick add items
  var quickAddedList = <Map<String, dynamic>>[].obs;

  // Discount-related fields
  var isAmount = true.obs; // true for "By Percent", false for "By Amount"
  var isPercentage = false.obs;
  final TextEditingController amount = TextEditingController();
  final TextEditingController percent = TextEditingController();

  var discountValue = 0.0.obs; // Store the applied discount

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
    quickAddedList.assignAll([
      {
        'productImage': 'assets/images/suger.jpg',
        'productname': 'Sugar(Chinni)',
        'productPrice': '20',
      },
      {
        'productImage': 'assets/images/jaggery.jpg',
        'productname': 'Jaggery(Gudd)',
        'productPrice': '15',
      },
      {
        'productImage': 'assets/images/coriander.webp',
        'productname': 'Coriander(Dhaniya)',
        'productPrice': '5',
      },
      {
        'productImage': 'assets/images/tomato.png',
        'productname': 'Tomato(Tamatar)',
        'productPrice': '10',
      },
    ]);
    updatePriceDetails(); // Initialize priceDetails
  }

  @override
  void onClose() {
    tabController.dispose();
    amount.dispose();
    super.onClose();
  }

  // Add item from quickAddedList to addedItems
  void addItemFromQuickList(int quickIndex) {
    final quickItem = quickAddedList[quickIndex];
    addedItems.add({
      'productname': quickItem['productname'],
      'productPrice': quickItem['productPrice'],
      'hasGift': false,
      'productImage': quickItem['productImage'],
    });
    isAdded.add(true);
    quantities.add(1);
    updatePriceDetails();
  }

  void incrementQuantity(int index) {
    quantities[index]++;
    updatePriceDetails();
  }

  void decrementQuantity(int index) {
    if (quantities[index] > 1) {
      quantities[index]--;
    } else {
      addedItems.removeAt(index);
      isAdded.removeAt(index);
      quantities.removeAt(index);
    }
    updatePriceDetails();
  }

  // Apply discount (by amount or percent)
  void applyDiscount(String input) {
    if (input.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a discount value',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    double value = double.tryParse(input) ?? 0.0;
    if (value <= 0) {
      Get.snackbar(
        'Error',
        'Please enter a valid discount value',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (isAmount.value && value > 100) {
      Get.snackbar(
        'Error',
        'Percentage cannot exceed 100%',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    discountValue.value = value;
    updatePriceDetails();
    Get.back();
    ();
  }

  // Update priceDetails based on cart and discount
  void updatePriceDetails() {
    int total = addedItems.fold(0, (sum, item) {
      int index = addedItems.indexOf(item);
      int price = int.tryParse(item['productPrice'] ?? '0') ?? 0;
      int quantity = quantities[index];
      return sum + (price * quantity);
    });
    double discount =
        isAmount.value
            ? total *
                (discountValue.value / 100) // By percent
            : discountValue.value; // By amount
    priceDetails[0]['price'] = '₹$total';
    priceDetails[0]['discountedPrice'] = '₹${(total - discount).round()}';
    priceDetails[4]['price'] = '₹${discount.round()}'; // Additional Discount
    // No need for refresh(); modifying priceDetails triggers Obx
  }

  var searchCustomer = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController sellingPrice = TextEditingController();

  void addItemToList(String name, String price) {
    if (name.isNotEmpty && price.isNotEmpty) {
      quickAddedList.add({
        'productImage': 'assets/images/null_product.png',
        'productname': name,
        'productPrice': price,
      });
      productName.clear();
      sellingPrice.clear();
      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
      ();
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  final List<Map<String, dynamic>> priceDetails =
      [
        {
          "title": "Item Total",
          "price": "₹3099",
          "discountedPrice": "₹1379",
          "isStrikethrough": true,
        },
        {"title": "MRP", "price": "₹3098"},
        {"title": "Product Discount", "price": "₹1750", "color": Colors.blue},
        {"title": "Promotional Discount", "price": "₹35"},
        {"title": "Additional Discount", "price": "₹35"},
        {"title": "Delivery fee 3.7 KM", "price": "₹35"},
        {"title": "Handling Charges", "price": "₹15"},
      ].obs; // RxList for reactivity

  var isOrderGiftChecked = false.obs;
  var isGiftDetailsVisible = false.obs;
  var giftMassage = TextEditingController();
  var name = TextEditingController();
  var selectedOption = "Home".obs;
  final deliveryExpansionState = false.obs;
  var isChanged = false.obs;

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }
}
