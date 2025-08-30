import 'package:get/get.dart';
import 'package:farmitra/app/ApiModels/getBusinessModuleResponse.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/services/network_services.dart';

class StoreDetailsController extends GetxController {
  final _apiService = ApiService();
  final _apiEndPoint = ApiEndpoints();

  final selectedIndex = (-1).obs;
  final previousSelectedValue = ''.obs;
  final storeOptions = <BusinessModule>[].obs;
  final isLoading = false.obs;

  BusinessModule? get selectedData =>
      selectedIndex.value >= 0 && selectedIndex.value < storeOptions.length
          ? storeOptions[selectedIndex.value]
          : null;
  void selectItem(int index) {
    if (index >= 0 && index < storeOptions.length) {
      selectedIndex.value = index;

      final selected = storeOptions[index];
      final id = selected.id.toString() ?? '';
      final name = selected.name ?? '';

      previousSelectedValue.value = 'id:$id,name:$name';

      print('Selected Item: Index=$index, ID=$id, Name=$name');
    } else {
      selectedIndex.value = -1;
      previousSelectedValue.value = '';
      print(
        'Invalid selection: Index=$index, storeOptions.length=${storeOptions.length}',
      );
    }
  }

  Future<void> fetchStoreOptions() async {
    try {
      isLoading.value = true;
      print('fetchStoreOptions: Starting API call at ${DateTime.now()}');
      // print('API Endpoint: ${_apiEndPoint.fetchBusinessModule}');

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.fetchBusinessModule,
        method: 'GET',
      );
      print('Raw API Response: $response');

      if (response == null) {
        print('Error: Null response from API');
        Get.snackbar(
          'Error',
          'No response from server. Please check your network.',
          snackPosition: SnackPosition.TOP,
        );
        _loadMockData();
        return;
      }

      if (response is! Map<String, dynamic>) {
        print(
          'Error: Invalid response type: ${response.runtimeType}, Response=$response',
        );
        Get.snackbar(
          'Error',
          'Invalid server response format. Expected JSON object.',
          snackPosition: SnackPosition.TOP,
        );
        _loadMockData();
        return;
      }

      // Check nested status
      final nestedResponse = response['data'] as Map<String, dynamic>?;
      if (nestedResponse == null) {
        print('Error: Missing nested data field in response: $response');
        Get.snackbar(
          'Error',
          'Invalid server response: Missing data field',
          snackPosition: SnackPosition.TOP,
        );
        _loadMockData();
        return;
      }

      final apiStatus = nestedResponse['status'];
      bool isSuccess =
          apiStatus == true || apiStatus == 'true' || apiStatus == 1;

      if (!isSuccess) {
        print(
          'API Error: Status=$apiStatus, Message=${nestedResponse['message']?.toString() ?? 'Unknown error'}, Nested Response=$nestedResponse',
        );
        Get.snackbar(
          'Error',
          nestedResponse['message']?.toString() ??
              'Failed to fetch business modules (Status: $apiStatus)',
          snackPosition: SnackPosition.TOP,
        );
        _loadMockData();
        return;
      }

      print('API Status: Success');
      final parsed = BusinessModulesResponse.fromJson(nestedResponse);
      print(
        'Parsed Data: ${parsed.data.map((e) => {'id': e.id, 'name': e.name, 'desc': e.desc, 'status': e.status, 'createdAt': e.createdAt, 'updatedAt': e.updatedAt}).toList()}',
      );

      if (parsed.data == null) {
        print('Error: Parsed data is null');
        Get.snackbar(
          'Error',
          'Invalid business module data from server',
          snackPosition: SnackPosition.TOP,
        );
        _loadMockData();
        return;
      }

      storeOptions.assignAll(parsed.data);
      print(
        'Assigned storeOptions: ${storeOptions.map((e) => {'id': e.id, 'name': e.name, 'desc': e.desc}).toList()}',
      );
      print('storeOptions Length: ${storeOptions.length}');

      if (storeOptions.isNotEmpty) {
        print('Selecting first item (index 0)');
        selectItem(0);
      } else {
        print('Warning: No business modules in parsed data');
        Get.snackbar(
          'Warning',
          'No business modules available from server',
          snackPosition: SnackPosition.TOP,
        );
        _loadMockData();
      }
    } catch (e, stackTrace) {
      print('Fetch Store Options Exception: $e\nStackTrace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to fetch business modules: $e',
        snackPosition: SnackPosition.TOP,
      );
      _loadMockData();
    } finally {
      isLoading.value = false;
      print(
        'Fetch completed: isLoading=${isLoading.value}, storeOptions.length=${storeOptions.length}',
      );
    }
  }

  void _loadMockData() {
    print('Loading mock data as fallback');
    storeOptions.assignAll([
      BusinessModule(
        id: 1,
        name: 'Retail',
        desc: 'Sell consumer goods',
        status: true,
        createdAt: DateTime.parse('2025-06-23T12:00:00Z'),
        updatedAt: DateTime.parse('2025-06-23T12:00:00Z'),
      ),
      BusinessModule(
        id: 2,
        name: 'Wholesale',
        desc: 'Sell goods in bulk',
        status: true,
        createdAt: DateTime.parse('2025-06-23T12:00:00Z'),
        updatedAt: DateTime.parse('2025-06-23T12:00:00Z'),
      ),
    ]);
    print(
      'Mock Data Assigned: ${storeOptions.map((e) => {'id': e.id, 'name': e.name, 'desc': e.desc}).toList()}',
    );
    if (storeOptions.isNotEmpty) {
      selectItem(0);
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('StoreDetailsController: onInit called');
    fetchStoreOptions();
  }
}
