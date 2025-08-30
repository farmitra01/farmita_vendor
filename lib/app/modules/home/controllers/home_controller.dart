import 'dart:async';

import 'package:farmitra/app/data/models/home_model/quick_access_model.dart';
import 'package:farmitra/app/data/models/home_model/sales_report_model.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  final count = 0.obs;
    final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    print('Stored Vendor Details on home page ${box.read('user_details')} ');
    print('Stored Vendor Role on home page ${box.read('user_role')}');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  void increment() => count.value++;
  var currentIndex = 0;
  var isTapped = false.obs;

  List<SalesReportModel> salesReport = [
    SalesReportModel(
      salesRepot: 'Today',
      imagePath: 'assets/icons/home_icons/Today.svg',
    ),
    SalesReportModel(
      salesRepot: 'Last 7 days',
      imagePath: 'assets/icons/home_icons/last7days.svg',
    ),
    SalesReportModel(
      salesRepot: 'Last 30 days',
      imagePath: 'assets/icons/home_icons/last30days.svg',
    ),
  ];

  List<QuickAccessModel> quickAccessGridItem = [
    QuickAccessModel(
      gridItemText: 'Appointment',
      gridItemIcon: Icons.calendar_month_outlined,
    ),
    QuickAccessModel(gridItemText: 'Feed', gridItemIcon: Icons.layers_outlined),
    QuickAccessModel(
      gridItemText: 'Khata Book',
      gridItemIcon: Icons.contact_mail_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Online Store',
      gridItemIcon: Icons.shopify_sharp,
    ),

    QuickAccessModel(
      gridItemText: 'Wallet',
      gridItemIcon: Icons.account_balance_wallet_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Chat',
      gridItemIcon: Icons.receipt_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Manage Appointment',
      gridItemIcon: Icons.discount_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'My Subscription',
      gridItemIcon: Icons.local_shipping_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Blog vs Govt Schem',
      gridItemIcon: Icons.hourglass_top_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Report',
      gridItemIcon: Icons.pie_chart_outline,
    ),
    QuickAccessModel(
      gridItemText: 'Ledger',
      gridItemIcon: Icons.receipt_long_sharp,
    ),
    QuickAccessModel(
      gridItemText: 'Analytics',
      gridItemIcon: Icons.analytics_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Coupons',
      gridItemIcon: Icons.confirmation_number_outlined,
    ),
    QuickAccessModel(gridItemText: 'Ads', gridItemIcon: Icons.campaign),
    QuickAccessModel(
      gridItemText: 'Business Card',
      gridItemIcon: Icons.credit_card_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Greetings',
      gridItemIcon: Icons.card_membership_sharp,
    ),

    QuickAccessModel(
      gridItemText: 'Customers',
      gridItemIcon: Icons.groups_2_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Refer & Earn',
      gridItemIcon: Icons.share_rounded,
    ),
    QuickAccessModel(
      gridItemText: 'Document Setting ',
      gridItemIcon: Icons.settings,
    ),
    QuickAccessModel(
      gridItemText: 'Help',
      gridItemIcon: Icons.headset_mic_outlined,
    ),
  ];

  List<QuickAccessModel> rentalGridItem = [
    QuickAccessModel(
      gridItemText: 'Appointment',
      gridItemIcon: Icons.storefront_outlined,
    ),
    QuickAccessModel(gridItemText: 'Feed', gridItemIcon: Icons.receipt_long),
    QuickAccessModel(
      gridItemText: 'Ledger',
      gridItemIcon: Icons.contact_mail_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Khata Book',
      gridItemIcon: Icons.shopify_sharp,
    ),
    QuickAccessModel(
      gridItemText: 'Blog vs Govt Schem',
      gridItemIcon: Icons.hourglass_top_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Chat',
      gridItemIcon: Icons.receipt_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Manage Services',
      gridItemIcon: Icons.discount_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Add Machine',
      gridItemIcon: Icons.inventory,
    ),

    QuickAccessModel(
      gridItemText: 'My Subscription',
      gridItemIcon: Icons.local_shipping_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Report',
      gridItemIcon: Icons.pie_chart_outline,
    ),
    QuickAccessModel(
      gridItemText: 'Analytics',
      gridItemIcon: Icons.analytics_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Business Card',
      gridItemIcon: Icons.credit_card_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Greetings',
      gridItemIcon: Icons.card_membership_sharp,
    ),

    QuickAccessModel(
      gridItemText: 'Customers',
      gridItemIcon: Icons.groups_2_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Refer & Earn',
      gridItemIcon: Icons.share_rounded,
    ),
    QuickAccessModel(
      gridItemText: 'Document Setting ',
      gridItemIcon: Icons.settings,
    ),
    QuickAccessModel(
      gridItemText: 'Help',
      gridItemIcon: Icons.headset_mic_outlined,
    ),
  ];

  List<QuickAccessModel> retailerGridItem = [
    QuickAccessModel(
      gridItemText: 'POS',
      gridItemIcon: Icons.storefront_outlined,
    ),
    // QuickAccessModel(gridItemText: 'Ledger', gridItemIcon: Icons.receipt_long),
    QuickAccessModel(
      gridItemText: 'Khata Book',
      gridItemIcon: Icons.contact_mail_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Online Store',
      gridItemIcon: Icons.shopify_sharp,
    ),
    QuickAccessModel(
      gridItemText: 'Orders on Hold',
      gridItemIcon: Icons.hourglass_top_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Invoice',
      gridItemIcon: Icons.receipt_outlined,
    ),

    QuickAccessModel(
      gridItemText: 'Sales',
      gridItemIcon: Icons.discount_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'My Subscription',
      gridItemIcon: Icons.local_shipping_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Parties',
      gridItemIcon: Icons.local_shipping_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Sales Order',
      gridItemIcon: Icons.file_download_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Inventory',
      gridItemIcon: Icons.inventory_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Expenses',
      gridItemIcon: Icons.account_balance_wallet_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Purchase Order',
      gridItemIcon: Icons.bar_chart_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Report',
      gridItemIcon: Icons.pie_chart_outline,
    ),
    QuickAccessModel(
      gridItemText: 'Analytics',
      gridItemIcon: Icons.analytics_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Business Card',
      gridItemIcon: Icons.credit_card_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Greetings',
      gridItemIcon: Icons.card_membership_sharp,
    ),
    QuickAccessModel(
      gridItemText: 'My Collections',
      gridItemIcon: Icons.collections_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Product Library',
      gridItemIcon: Icons.library_books_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Customers',
      gridItemIcon: Icons.groups_2_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Invoice Template',
      gridItemIcon: Icons.upload_file_outlined,
    ),
    QuickAccessModel(
      gridItemText: 'Refer & Earn',
      gridItemIcon: Icons.share_rounded,
    ),
    QuickAccessModel(
      gridItemText: 'Document Setting ',
      gridItemIcon: Icons.settings,
    ),
    QuickAccessModel(
      gridItemText: 'Help',
      gridItemIcon: Icons.headset_mic_outlined,
    ),
  ];

  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    hours.value = 0;
    minutes.value = 0;
    seconds.value = 0;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value < 59) {
        seconds.value++;
      } else {
        seconds.value = 0;
        if (minutes.value < 59) {
          minutes.value++;
        } else {
          minutes.value = 0;
          hours.value++;
        }
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
