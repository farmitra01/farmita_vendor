import 'package:get/get.dart';

class PosCategorySearchController extends GetxController {
  //TODO: Implement PosCategorySearchController

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
  var isSearch = false.obs;

  void onTap(){
    isSearch.value = true;
  }
}
