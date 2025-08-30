// import 'package:farmitra/app/data/models/store_profile/views/profile_view.dart';
import 'package:farmitra/app/data/models/store_about_model/store_about_model.dart';
import 'package:farmitra/app/modules/POS/views/pos_view.dart';
import 'package:farmitra/app/modules/home/views/Appointment.dart';
import 'package:farmitra/app/modules/home/views/chat_view.dart';
import 'package:farmitra/app/modules/home/views/feed.dart';
import 'package:farmitra/app/modules/home/views/first_med_order.dart';
import 'package:farmitra/app/modules/home/views/home_view.dart';
import 'package:farmitra/app/modules/home/views/order_view.dart';
import 'package:farmitra/app/modules/inventory/views/inventory_view.dart';
import 'package:farmitra/app/modules/my_subscription/views/my_subscription_view.dart';
import 'package:farmitra/app/modules/owner_profile/views/owner_profile_view.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_selected_module_controller.dart';
import 'package:farmitra/app/modules/storeProfile/views/expert_profile.dart';
import 'package:farmitra/app/modules/storeProfile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeBottomBarController extends GetxController {
  //TODO: Implement HomeBottomBarController

  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  final StoreSelectedModuleController storeSelectedModuleController = Get.put(
    StoreSelectedModuleController(),
  );
  var previousPageGridTitle = Get.arguments;

  var box;
  var user_id = '';
  var user_name = '';
  final count = 0.obs;
  @override
  void onInit() async {
    box = GetStorage();
    super
        .onInit(); // print('111 Stored Role ${box.read('user_role')}'); // print( // 'Stored Vendor Details on home bottom bar page ${box.read('user_details')} ', // ); // print("User id in storage ${box.read('user_details')['id']}"); // print("User name in storage ${box.read('user_details')['store_name']}");

    user_id = box.read('user_role').toString();
    user_name =
        box
            .read('user_details')['data']['data']['vendor']['store_name']
            .toString();
    // user_name = box.read('user_details')?['store_name'];
    print('user id Stored in user_id variabel = ${user_id}');
    print('Stored Name of Store on home bottom bar page = $user_name');
    print(
      'Stored User Details on home bottom bar page = ${box.read('user_details')}',
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  var currentIndex = 0.obs;

  void onTapIndex(int index) {
    currentIndex.value = index;
  }

  List<Widget> get pages => [
    HomeView(),
    // storeSelectedModuleController.previousSelectedValue == 'As a Retailer'
    box.read('user_role') == 'Vendor' ? OrderView() : Feed(),

    storeCategoryController.previousPageGridTitle == 'Med'
        ? FirstMedOrder()
        :
        // InventoryView(),
        ChatView(),

    // box.read('user_role') == 'Vendor' ? PosView() : MySubscriptionView(),
    // storeSelectedModuleController.previousSelectedValue == 'As a Retailer'
    box.read('user_role') == 'Vendor' ? ProfileView() : ExpertProfile(),
  ];
  // ProfileView()
  // previousPageGridTitle == "Med" ? FirstMedOrder() : OrderView(),
}
