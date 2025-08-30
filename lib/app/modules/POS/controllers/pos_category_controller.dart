import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PosCategoryController extends GetxController {
  //TODO: Implement PosCategoryController
  late Box box;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // box = Hive.box('MyBox');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void addData() {
  //   box.put(
  //     'data3',
  //     '1212121212',
  //   );
  //   print("Data Added Successfully😁👍");
  // }

  // void deletedData() {
  //   box.delete('data');
  //   print("Data Deleted Successfully😁👍");
  // }

  // void getData() {
  //   var NUM = box.toMap();
  //   print(NUM);
  // }

  var IsSortSelected = ''.obs;

  void OnRadioSelected(String? value) {
    IsSortSelected.value = value ?? '';
  }

  List<String> sortTypeList = [
    'Relevance',
    'Popularity',
    'Price: Low to High',
    'Price: High to Low',
    'Newest First',
  ].obs;

  void increment() => count.value++;
  var selectedIndex = 0.obs;
  var ifSelected = true.obs;
  RxList<int> quantities = List.filled(20, 0).obs;
  void incrementQuantity(int index) {
    quantities[index]++;
  }

  void decrementQuantity(int index) {
    if (quantities[index] > 0) {
      quantities[index]--;
    }
  }

  var isShowItemAddedBar = false.obs;
}
