import 'package:get/get.dart';

class SelectDocumentController extends GetxController {
  //TODO: Implement SelectDocumentController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  var selectedDocument = ''.obs;

  List<String> documentsList = [
    'GST-C OTP Varification',
    "Shop's Establishment License",
    'UDYOG/UDYAM',
    'Food/Drug License',
    'Trade License',
    'Other Document(if any)',
  ];
  List<String> qualificationsList = [
    'Doctrate',
    'Masters',
    'Graduate',
    'Others',
  ];
}
