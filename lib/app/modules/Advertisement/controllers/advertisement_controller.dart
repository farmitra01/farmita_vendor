import 'package:get/get.dart';

class AdvertisementController extends GetxController {
  // Observable for selected ad type index
  var selectedAdTypeIndex = 0.obs;

  // List of ad types and their counts
  var adTypes =
      [
        {'type': 'All', 'count': 5},
        {'type': 'Active', 'count': 3},
        {'type': 'Expired', 'count': 2},
      ].obs;

  // Toggle switch observable
  var isSwitched = false.obs;

  // Method to update selected ad type
  void selectAdType(int index) {
    selectedAdTypeIndex.value = index;
    print('Selected Ad Type Index: $index');
  }

  // Method to toggle switch
  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  // Example counter (optional)
  final count = 0.obs;

  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();
    // You can fetch adTypes from API here if needed
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
