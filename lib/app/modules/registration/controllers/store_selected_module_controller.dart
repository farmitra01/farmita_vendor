import 'dart:convert';
import 'dart:math';

import 'package:farmitra/app/ApiModels/modulCategory.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreSelectedModuleController extends GetxController {
  final _apiService = ApiService();
  final dynamic previousSelectedValue = Get.arguments;

  final RxInt selectedIndex = 0.obs;
  final RxString gridTitle = ''.obs;
  final RxBool isLoading = false.obs;

  final RxList<ModuleCategoryModel> items = <ModuleCategoryModel>[].obs;
  final RxList<ModuleCategoryModel> items2 = <ModuleCategoryModel>[].obs;

  final List<Color> colors = List.generate(
    11,
    (_) => Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    debugPrint(
      'StoreSelectedModuleController: onInit called, instance=$hashCode, previousSelectedValue=$previousSelectedValue',
    );
    _parseAndFetch();
  }

  void _parseAndFetch() {
    int? categoryId;
    String? categoryName;

    if (previousSelectedValue is String) {
      final parts = previousSelectedValue.split(',');
      for (var part in parts) {
        if (part.startsWith('id:')) {
          categoryId = int.tryParse(part.split(':')[1]);
        } else if (part.startsWith('name:')) {
          categoryName = part.split(':')[1];
        }
      }
    }

    if (categoryId != null) {
      fetchModuleCategories2(categoryId, categoryName: categoryName);
    } else {
      debugPrint('❌ Missing ID: fallback triggered, instance=$hashCode');
    }
  }

  // Reactive list of module categories
  var items3 = <ModuleCategoryModel>[].obs;

  // Optional: Reactive single category for detail use
  var selectedCategory = Rxn<ModuleCategoryModel>();

  Future<void> fetchModuleCategories2(int id, {String? categoryName}) async {
    try {
      isLoading.value = true;

      final endpointUrl = '/module-category/$id';
      debugPrint('Requesting API: $endpointUrl');

      final response = await _apiService.callApi(
        endpoint: endpointUrl,
        method: 'GET',
      );

      debugPrint('Raw API Response: ${response.toString()}');

      // Extract and map list of categories
      final List<dynamic>? dataList = response['data']?['data'];
      if (dataList != null && dataList.isNotEmpty) {
        final parsedList =
            dataList.map((item) => ModuleCategoryModel.fromJson(item)).toList();

        items3.value = parsedList;

        // Automatically select index 0 if data exists
        if (items3.isNotEmpty) {
          selectItem(0); // Select the first item by default
          // Optionally send the data as an argument
          _sendDefaultArgument();
        }

        debugPrint('Parsed ${items3.first.name} module categories');
      } else {
        items.clear();
        debugPrint('No categories found.');
      }
    } catch (e) {
      debugPrint('Exception during fetchModuleCategories: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch modules.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
      debugPrint('Fetch completed: ${items3.length} items, instance=$hashCode');
    }
  }

  void _sendDefaultArgument() {
    if (items3.isNotEmpty) {
      final defaultData =
          'id:${items3[0].id},name:${items3[0].name ?? 'Unknown'}';
      debugPrint('Sending default argument: $defaultData');
    }
  }

  void selectItem(int index) {
    if (index >= 0 && index < items3.length) {
      selectedIndex.value = index;
      gridTitle.value =
          'id:${items3[index].id},name:${items3[index].name ?? 'Unknown'}';
      debugPrint(
        '✅ Selected Item: Index=$index, ID=${items3[index].id}, Name=${items3[index].name}, GridTitle=${gridTitle.value}, instance=$hashCode',
      );
    }
  }
}
