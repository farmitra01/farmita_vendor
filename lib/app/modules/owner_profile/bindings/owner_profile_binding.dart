import 'package:get/get.dart';

import '../controllers/owner_profile_controller.dart';

class OwnerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerProfileController>(
      () => OwnerProfileController(),
    );
  }
}
