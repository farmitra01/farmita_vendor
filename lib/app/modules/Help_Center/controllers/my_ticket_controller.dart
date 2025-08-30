import 'package:farmitra/app/ApiModels/getMyGreviances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';

class MyTicketController extends GetxController {
  final _apiService = ApiService();

  var isLoading = false.obs;
  var grievanceTicketList = <GrievanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGrievanceTickets();
  }

  Future<void> fetchGrievanceTickets() async {
    try {
      isLoading.value = true;
      final resp = await _apiService.callApi(
        endpoint: ApiEndpoints.fetchGrevienceTicket,
        method: 'GET',
      );
      debugPrint('✉️ Raw API response: $resp');

      final outerData = resp['data'];
      if (resp['success'] == true &&
          outerData is Map<String, dynamic> &&
          outerData['data'] is List) {
        final grievanceList = outerData['data'] as List<dynamic>;
        debugPrint('📥 List length from API: ${grievanceList.length}');
        grievanceTicketList.value = GrievanceModel.listFromJson(grievanceList);
      }
    } catch (e) {
      debugPrint('❌ Error fetching tickets: $e');
      Get.snackbar('Error', 'Failed to fetch tickets');
    } finally {
      isLoading.value = false;
    }
  }

  String fullImageUrl(String imagePath) {
    return '${ApiEndpoints.baseUrl}$imagePath';
  }
}
