import 'package:get/get.dart';

class OwnersDetailscontroller extends GetxController {
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

  List<String> documentsList = [
    'Aadhar Card',
    'PAN Card',
    'Voter ID',
    'Passport',
    'Driving License',
    'Other Document(if any)'
  ];
}
