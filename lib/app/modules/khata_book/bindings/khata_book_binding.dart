import 'package:get/get.dart';

import '../controllers/khata_book_controller.dart';

class KhataBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataBookController>(
      () => KhataBookController(),
    );
  }
}
