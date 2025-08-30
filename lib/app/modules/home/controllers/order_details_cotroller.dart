import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/models/order_model/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var isExpanded = false.obs;
  var isOrderAccepted = false.obs;

  final List<Map<String, dynamic>> customerDetails = [
    {"title": "Email", "data": "subamrawatgzp@gmail.com"},
    {
      "title": "Address",
      "data": "House No 411 WardNo 5 ,Mo- Masulghat ,post- Satti Maszid",
    },
    {"title": "City", "data": "Ghazipur"},
    {"title": "Pin Code", "data": "233001"},
    {"title": "Payment", "data": "Online Payment"},
    {"title": "Status", "data": "Paid"},
  ];

  final List<Map<String, dynamic>> priceDetails = [
    {
      "title": "Item Total",
      "price": "₹3099",
      "discountedPrice": "₹1379",
      "isStrikethrough": true,
    },
    {"title": "MRP", "price": "₹3098"},
    {
      "title": "Product Discount",
      "price": "₹1750",
      "color": AppColors.lightskyBlue,
    },
    {"title": "Promotional Discount", "price": "₹35"},
    {"title": "Additional Discount", "price": "₹35"},
    {"title": "Delivery fee 3.7 KM", "price": "₹35"},
    {"title": "Handling Charges", "price": "₹15"},
  ];
  // double buttonPosition = 0;
  int currentStep = 0;
  var giftmsg = TextEditingController();
  List<OrderDetailsModel> stepDetails = [
    OrderDetailsModel(
      text: "Order Placed",
      time: "29 Sep 2022 05:10 PM",
      icon: Icons.check,
    ),
    OrderDetailsModel(
      text: "Payment Done",
      time: '29 Sep 2022 05:16 PM',
      icon: Icons.kitchen,
    ),
    OrderDetailsModel(
      text: "Order Conformed",
      time: "29 Sep 2022 05:16 PM",
      icon: Icons.assignment_turned_in,
    ),
    OrderDetailsModel(
      text: "Preparing Order / Cooking",
      time: '29 Sep 2022 05:16 PM',
      icon: Icons.person,
    ),
    OrderDetailsModel(
      text: "Ready to Delivery",
      time: '29 Sep 2022 05:16 PM',
      icon: Icons.shopping_bag,
    ),
    OrderDetailsModel(
      text: "Delivery Partner Assigned",
      time: '29 Sep 2022 05:16 PM',
      icon: Icons.delivery_dining,
    ),
    OrderDetailsModel(
      text: "Order Pickup",
      time: '29 Sep 2022 05:35 PM',
      icon: Icons.check_circle,
    ),
  ];

  var buttonPosition = 0.0.obs;

  // Method to update button position
  void updatePosition(double deltaX) {
    buttonPosition.value += deltaX;

    // Keep the button within bounds
    if (buttonPosition.value < 0) {
      buttonPosition.value = 0;
    } else if (buttonPosition.value > 280) {
      buttonPosition.value = 280;
    }
  }

  // Method to handle slider end logics
  void onDragEnd() {
    if (buttonPosition.value > 200) {
      buttonPosition.value = 275; // Snap to the right
      ''; // Close the bottom sheet
      isOrderAccepted.value = false;
      print("Order Started!");
    } else {
      buttonPosition.value = 0; // Snap back to the left
    }
  }

  void launchDialPad(String phoneNumber) async {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch dial pad");
    }
  }
}
