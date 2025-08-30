import 'package:get/get.dart';

import '../controllers/inventry_controller.dart';

class InventryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventryController>(
      () => InventryController(),
    );
  }
}
