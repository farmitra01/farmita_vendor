import 'package:farmitra/app/modules/bank_details/controllers/bank_details_form_controller.dart';
import 'package:farmitra/app/modules/bank_details/controllers/thank_you_controller.dart';
import 'package:farmitra/app/modules/bank_details/controllers/upi_details_controller.dart';
import 'package:get/get.dart';



import '../controllers/bank_details_controller.dart';

class BankDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThankYouController>(
      () => ThankYouController(),
    );
    Get.lazyPut<BankDetailsFormController>(
      () => BankDetailsFormController(),
    );
    Get.lazyPut<UpiDetailsController>(
      () => UpiDetailsController(),
    );
    Get.lazyPut<BankDetailsController>(
      () => BankDetailsController(),
    );
  }
}
