import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/models/order_model/order_details_model.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_checkout_controller.dart';
import 'package:farmitra/app/modules/POS/views/pos_view.dart';
import 'package:farmitra/app/modules/home/controllers/first_med_controller.dart';
import 'package:farmitra/app/modules/home/views/med_order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class MedOrderDetailsController extends GetxController {
  final List<dynamic> args = Get.arguments ?? [false, false];
  final FirstMedController firstMedController = Get.put(FirstMedController());
  final PosCheckoutController posCheckoutController = Get.put(
    PosCheckoutController(),
  );
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

  var isSendingOrder = false.obs;
  var isWaiting = false.obs;
  var isAssigDelieveryPartner = false.obs;
  var isPreparingOrder = false.obs;
  var isEstimatedTime = false.obs;
  var isBeforeTime = false.obs;

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
    print('onDragEnd called - buttonPosition: ${buttonPosition.value}');
    print(
      'States - isSendingOrder: ${isSendingOrder.value}, isWaiting: ${isWaiting.value}, '
      'isAssigDelieveryPartner: ${isAssigDelieveryPartner.value}, isEstimatedTime: ${isEstimatedTime.value}',
    );

    if (buttonPosition.value > 200) {
      buttonPosition.value = 275; // Snap to the right
      print('Snapped to right: 275');

      if (firstMedController.isPrescriptionTapped == true &&
          posCheckoutController.isChanged.value == false) {
        print('Case 1: Prescription tapped, navigating to PosView');
        Get.to(() => PosView());
        buttonPosition.value = 0;
        isSendingOrder.value = true;
        print('SendingOrder set to true: ${isSendingOrder.value}');
      } else if (isSendingOrder.value == true) {
        print('Case 2: Sending order, setting isWaiting to true');
        isWaiting.value = true;
        isSendingOrder.value = false;
        // isAssigDelieveryPartner.value = false;

        print('Waiting set to true: ${isWaiting.value}');
        Future.delayed(Duration(seconds: 5), () {
          buttonPosition.value = 0;
          isAssigDelieveryPartner.value = true;
          isSendingOrder.value = false; // Already false, but kept for clarity
          isWaiting.value = false;
          isPreparingOrder.value = true;
          print(
            'After 5s - Delivery partner: ${isAssigDelieveryPartner.value}',
          );
        });
      } else if (isPreparingOrder.value == true &&
          isEstimatedTime.value == false) {
        isAssigDelieveryPartner.value = false;
        print('Case 3: Setting estimated time');

        // isPreparingOrder.value = true;
        Get.dialog(buildEstimatedTimerPopUp());
        Future.delayed(Duration(seconds: 3), () {
          buttonPosition.value = 0;
          isEstimatedTime.value = true;
        });
        // isPreparingOrder.value = false; // Uncomment if you want to reset this
        print('Estimated time activated: ${isEstimatedTime.value}');
        print('Start preparing order set to true: ${isPreparingOrder.value}');
      } else if (isPreparingOrder.value == true &&
          isEstimatedTime.value == true) {
        buttonPosition.value = 0;

        print('Case 4: Estimated time state reached');
        print(
          'Estimated Time 00:00 Edit displayed in UI',
        ); // Print confirmation
        // Optionally reopen dialog if needed: Get.dialog(buildEstimatedTimerPopUp());
      } else {
        print('Default case: Snapping back to 0');
        // buttonPosition.value = 0;
      }
    } else {
      print('Drag < 200, snapping back to 0');
      buttonPosition.value = 0;
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

  var estimatedTime = TextEditingController();
}
