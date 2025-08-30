import 'package:farmitra/app/modules/storeProfile/controllers/about_controller.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/review_controller.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/storeTabProfile_controller.dart';
import 'package:get/get.dart';



import '../controllers/store_profile_controller.dart';

class StoreProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(
      () => AboutController(),
    );
    Get.lazyPut<ReviewController>(
      () => ReviewController(),
    );
    Get.lazyPut<StoresTabProfileController>(() => StoresTabProfileController());
    Get.lazyPut<StoreProfileController>(
      () => StoreProfileController(),
    );
  }
}
