import 'package:farmitra/app/ApiModels/getModuleSubCategory.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreCategoryController extends GetxController {
  // Reactive variables
  final RxSet<int> selectedItems = <int>{}.obs;
  final RxList<ModuleSubCategory> gridContent = <ModuleSubCategory>[].obs;
  final RxList<ModuleSubCategory> subCategories = <ModuleSubCategory>[].obs;
  final RxList<int> subCategoriesId = <int>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = 0.obs;

  final RxString moduleCategoryId = ''.obs;
  final RxString businessModuleId = ''.obs;
  final TextEditingController customeCategory = TextEditingController();

  // API service
  final ApiService _apiService = ApiService();

  // Get arguments from previous screen
  final dynamic previousPageGridTitle = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    _parseAndFetch();
    debugPrint('🛠️ Argument of Nature of Business: $previousPageGridTitle');
  }

  // Toggle selection status of an item
  void toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
    debugPrint('✅ Selected items: ${selectedItems.toList()}');
  }

  // Add new item to the grid
  void addGridItem(ModuleSubCategory newItem) {
    gridContent.add(newItem);
    debugPrint('🆕 Added new item: ${newItem.name}');
  }

  // Parse arguments and fetch data
  void _parseAndFetch() {
    int? categoryId;
    String? categoryName;

    if (previousPageGridTitle is String) {
      final parts = previousPageGridTitle.split(',');
      for (var part in parts) {
        if (part.startsWith('id:')) {
          categoryId = int.tryParse(part.split(':')[1]);
        } else if (part.startsWith('name:')) {
          categoryName = part.split(':')[1];
        }
      }
    }

    if (categoryId != null) {
      fetchModuleSubCategory(categoryId, name: categoryName);
    } else {
      debugPrint('❌ Missing ID: fallback triggered');
    
    }
  }

  // Fetch subcategories from API
  Future<void> fetchModuleSubCategory(int id, {String? name}) async {
    try {
      isLoading.value = true;

      final endpointUrl = '/module-subcategory/$id';
      debugPrint('🌐 Requesting API: $endpointUrl');

      final response = await _apiService.callApi(
        endpoint: endpointUrl,
        method: 'GET',
      );

      debugPrint('📦 Raw API Response: $response');

      final List<dynamic>? dataList =
          response['data']?['data'] ?? response['data'];

      if (dataList != null && dataList.isNotEmpty) {
        final parsedList =
            dataList.map((item) => ModuleSubCategory.fromJson(item)).toList();

        subCategories.value = parsedList;
        gridContent.value = parsedList;

        // Select first item by default
        if (subCategories.isNotEmpty) {
          selectItem(0);
          _sendDefaultArgument();
        }

        debugPrint('✅ Parsed ${subCategories.length} subcategories');
      } else {
        subCategories.clear();
        gridContent.clear();
        debugPrint('⚠️ No subcategories found');
      }
    } catch (e) {
      debugPrint('❗ Exception during fetch: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch subcategories.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
      debugPrint(
        '🔁 Fetch completed: ${subCategories.length} items',
      );
    }
  }

  // Select an item and update selectedIndex
  void selectItem(int index) {
    if (index >= 0 && index < subCategories.length) {
      selectedIndex.value = index;
      debugPrint(
        '👉 Selected Item: Index=$index, ID=${subCategories[index].id}, Name=${subCategories[index].name}',
      );
    }
  }
 
  // Send default values (first item)
  void _sendDefaultArgument() {
    if (subCategories.isNotEmpty) {
      final firstItem = subCategories[0];

      businessModuleId.value = firstItem.business_module_id.toString();
      moduleCategoryId.value = firstItem.moduleCategoryId.toString();
      subCategoriesId.value = [firstItem.id]; // ✅ FIXED: correct assignment

      debugPrint('➡️ Default Selected:');
      debugPrint('   - business_module_id: ${businessModuleId.value}');
      debugPrint('   - module_category_id: ${moduleCategoryId.value}');
      debugPrint('   - subcategory_id: ${subCategoriesId.value}');
    } else {
      debugPrint('⚠️ No subcategories available for default assignment.');
    }
  }

  @override
  void onClose() {
    customeCategory.dispose();
    super.onClose();
  }
}
