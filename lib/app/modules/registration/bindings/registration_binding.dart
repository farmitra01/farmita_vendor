import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_template_controller.dart';
import 'package:get/get.dart';



import '../controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreLocationController>(
      () => StoreLocationController(),
    );
    // Get.lazyPut<StoreLocationController>(
    //   () => StoreLocationController(),
    // );
    Get.lazyPut<StoreTemplateController>(
      () => StoreTemplateController(),
    );
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
