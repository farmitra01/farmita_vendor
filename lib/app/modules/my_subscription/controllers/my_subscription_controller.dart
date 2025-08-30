import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/ApiModels/get-business-plans.dart';

class MySubscriptionController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<PlanResponse> plans = <PlanResponse>[].obs;
  var selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Tab data
  RxList<String> tabs = ['Silver', 'Gold', 'Platinum'].obs;

  // Mapping UI tab to API value
  final Map<String, String> subscriptionTypeMap = {
    'Silver': 'Silver',
    'Gold': 'Gold',
    'Platinum': 'Diamond',
  };

  RxInt tabIndex = 0.obs;
  RxString selectedType = 'Silver'.obs;

  RxBool trial = false.obs;
  RxBool renew = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans(); // Fetch default tab on init
  }

  void changeTab(int index) {
    tabIndex.value = index;
    selectedType.value = tabs[index];
    errorMessage.value = '';
    fetchPlans();
  }

  void selectPlan(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final apiType =
          subscriptionTypeMap[selectedType.value] ?? selectedType.value;
      debugPrint('📡 Fetching plans for: ${selectedType.value}');
      debugPrint(
        'Request URL: ${ApiEndpoints.getBusinessPlans}?subscription_type=$apiType',
      );

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.getBusinessPlans,
        method: 'GET',
        queryParams: {'subscription_type': apiType},
      );

      debugPrint('📬 Raw API response: $response');

      // ✅ CORRECT ACCESS
      final innerData = response['data'];
      final planList = innerData?['data']; // this is the actual array

      if (planList is List) {
        plans.value = PlanResponse.listFromJson(planList);
        debugPrint('✅ Plans fetched: ${plans.length}');
      } else {
        errorMessage.value = 'Unexpected data format from API.';
        debugPrint('❗ Unexpected data format: $innerData');
        plans.clear();
      }
    } catch (e) {
      errorMessage.value = 'Error fetching plans: $e';
      plans.clear();
      debugPrint('❌ Exception: $e');
    } finally {
      isLoading.value = false;
      if (errorMessage.value.isNotEmpty) {
        Get.snackbar('Error', errorMessage.value);
      }
    }
  }
}
