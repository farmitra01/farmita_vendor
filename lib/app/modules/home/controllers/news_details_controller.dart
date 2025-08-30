import 'package:farmitra/app/ApiModels/get-blog.dart' as blog_model;
import 'package:farmitra/app/ApiModels/get_blog_news_details.dart'
    as detail_model;
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewsDetailsController extends GetxController {
  final isLoading = true.obs;

  final blog = Rxn<detail_model.BlogPost>();
  final relatedBlogs = <detail_model.RelatedPost>[].obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    final int? id = Get.arguments as int?;
    if (id != null) {
      print('argumeted id = $id');
      fetchBlogDetails(id);
    } else {
      _handleMissingId();
    }
  }
  void _handleMissingId() {
    Get.snackbar(
      'Error',
      'No blog ID provided',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
    );
    isLoading(false);
  }
  String getFullImageUrl(String relativePath) {
  const baseUrl = 'https://api.farmitra.in/storage/';
  return '$baseUrl$relativePath';
} 

  Future<void> fetchBlogDetails(int id) async {
    try {
      isLoading(true);
      final token = getAuthToken();

      final response = await _apiService.callApi(
        endpoint: '/view-blogs-by-id/$id',
        method: 'GET',
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );

      final data = response['data'];
      if (data != null && data['status'] == true) {
        final blogResponse = detail_model.BlogResponse.fromJson(data);
        blog.value = blogResponse.data;
        relatedBlogs.assignAll(blogResponse.related);
      } else {
        _handleFetchError(data?['message'] ?? 'Failed to fetch blog details');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      _handleFetchError('An error occurred while loading blog details.');
    } finally {
      isLoading(false);
    }
  }

  void _handleFetchError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
    );
  }

  String? getAuthToken() {
    final storage = GetStorage();
    return storage.read('auth_token') as String?;
  }
}
