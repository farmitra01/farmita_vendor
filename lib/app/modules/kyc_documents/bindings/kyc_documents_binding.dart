import 'package:farmitra/app/modules/kyc_documents/controllers/business_kyc_controller_controller.dart';
import 'package:farmitra/app/modules/kyc_documents/controllers/select_document_controller.dart';
import 'package:get/get.dart';

import '../controllers/kyc_documents_controller.dart';

class KycDocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessKycControllerController>(
      () => BusinessKycControllerController(),
    );
    Get.lazyPut<SelectDocumentController>(() => SelectDocumentController());
    Get.lazyPut<KycDocumentsController>(() => KycDocumentsController());
  }
}
