import 'package:farmitra/app/modules/home/controllers/chat_controller.dart';
import 'package:farmitra/app/modules/home/controllers/home_bottom_bar_controller.dart';
import 'package:farmitra/app/modules/home/controllers/order_controller.dart';
import 'package:farmitra/app/modules/home/controllers/profile_controller.dart';
import 'package:get/get.dart';



import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<HomeBottomBarController>(
      () => HomeBottomBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
