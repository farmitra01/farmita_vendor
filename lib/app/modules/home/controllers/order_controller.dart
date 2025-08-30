import 'package:farmitra/app/data/models/order_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement OrderController
  late TabController tabController;
  late TabController orderStatus;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    orderStatus = TabController(length: 4, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;

  List<OrderModel> orderStatusList = [
    OrderModel(
      text: "Pending",
      number: 15,
      bgColor: Color(0xff0FFDEDE),
      textColor: Color(0xffDB5050),
    ),
    OrderModel(
      text: "Preparing",
      number: 15,
      bgColor: Color(0xffFFDAC6),
      textColor: Color(0xffF27129),
    ),
    OrderModel(
      text: "Packed",
      number: 15,
      bgColor: Color(0xffDEF9E2),
      textColor: Color(0xff02B93B),
    ),
    OrderModel(
        text: "Delievry Assigned",
        number: 15,
        bgColor: Color(0xffFFF1D8),
        textColor: Color(0xffC89666))
  ];
}
