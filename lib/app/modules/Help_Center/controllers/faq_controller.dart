import 'dart:convert';

import 'package:farmitra/app/ApiModels/getfaqs.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/data/models/help_center_model/faq_grid_model.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  //TODO: Implement FaqController
  var items = <Faq_Grid_Model>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var faqMap = <String, List<FaqModel>>{}.obs;
  var faqCategoryList = <String>[].obs;

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.fetchFaqs,
        method: 'GET',
      );

      final rawNestedData = response['data'];
      final faqData = rawNestedData?['data'];

      if (response['success'] == true && faqData is Map<String, dynamic>) {
        final parsedMap = <String, List<FaqModel>>{};

        faqData.forEach((key, value) {
          if (value is List) {
            parsedMap[key] =
                value
                    .whereType<Map<String, dynamic>>()
                    .map((item) => FaqModel.fromJson(item))
                    .toList();
          }
        });
        faqMap.value = parsedMap;
        faqCategoryList.clear();
        faqCategoryList.addAll(parsedMap.keys);
      } else {
        Get.snackbar('Error', 'Invalid FAQ data from server');
      }
    } catch (e) {
      debugPrint('Error fetching FAQs: $e');
      Get.snackbar('Error', 'Failed to fetch FAQs');
    } finally {
      isLoading.value = false;
    }
  }
}
