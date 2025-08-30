import 'package:farmitra/app/modules/POS/controllers/added_item_controller.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_category_controller.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_category_search_controller.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_search_result_controller.dart';
import 'package:get/get.dart';



import '../controllers/pos_controller.dart';

class PosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosSearchResultController>(
      () => PosSearchResultController(),
    );
    Get.lazyPut<AddedItemController>(
      () => AddedItemController(),
    );
    Get.lazyPut<PosCategorySearchController>(
      () => PosCategorySearchController(),
    );
    Get.lazyPut<PosCategoryController>(
      () => PosCategoryController(),
    );
    Get.lazyPut<PosController>(
      () => PosController(),
    );
  }
}
