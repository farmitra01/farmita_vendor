import 'package:get/get.dart';

class AppointmentDetailsController extends GetxController {
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

  List<String> cropImage = [
    'assets/images/placeholder.jpg',  
    'assets/images/placeholder.jpg',  
    'assets/images/placeholder.jpg',
  ];
}
