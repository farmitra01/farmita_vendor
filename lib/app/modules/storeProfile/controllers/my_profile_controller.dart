import 'package:farmitra/app/ApiModels/getAllComment.dart';
import 'package:farmitra/app/ApiModels/getPost.dart';
import 'package:farmitra/app/ApiModels/postComment.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController
    with GetTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabChange);
    fetchPosts();
    // fetchBlogs();
    report.addListener(() {
      reportCharCount.value = report.text.length;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _handleTabChange() {
    print('Tab changed to index: ${tabController.index}');
    if (!tabController.indexIsChanging) {
      if (tabController.index == 0) {
        fetchPosts();
      } else if (tabController.index == 1) {
        // fetchPostedVideo();
      } else if (tabController.index == 2) {
        // fetchBlogs();
      }
    }
  }

  void increment() => count.value++;

  List<Map<String, dynamic>> profileDetail = [
    {'count': '100', 'details': 'Post'},
    {'count': '10k', 'details': 'Followers'},
    {'count': '5k', 'details': 'Following'},
  ];

  final String _baseImageUrl = 'https://api.farmitra.in/storage/';

  List<String> getImageUrlsForPost(int postId) {
    final post = posts.firstWhereOrNull((post) => post.id == postId);
    return post?.postImages
            .map((image) => '$_baseImageUrl${image.image}')
            .toList() ??
        [];
  }

  final ApiService _apiService = ApiService();
  final isLoading = false.obs;
  RxList<Post> posts = <Post>[].obs;
  var comments = <CommentModel>[].obs;
  final reply = TextEditingController();
  final report = TextEditingController();
  final RxInt reportCharCount = 0.obs;

  final List<Map<String, dynamic>> action = [
    {'icon': Icons.favorite_outline_outlined, 'count': '45'},
    {'icon': Icons.chat, 'count': '5'},
    {'icon': Icons.bookmark_add, 'count': '10'},
    {'icon': Icons.share, 'count': '15'},
  ];

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.getUserPost,
        method: 'GET',
      );
      if (response['statusCode'] == 200 && response['data'] != null) {
        final postResponse = PostResponse.fromJson(response['data']);
        posts.assignAll(postResponse.data);
      } else {
        showErrorSnackbar(
          'Error',
          response['data']['message'] ?? 'Failed to fetch posts',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      isLoading.value = true;
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.deleteUsertPost,
        method: 'POST',
        body: {'post_id': postId},
      );
      if (response['statusCode'] == 200 || response['statusCode'] == 204) {
        posts.removeWhere((post) => post.id == postId);
        showSuccessSnackbar('Success', 'Post deleted successfully');
      } else {
        showErrorSnackbar(
          'Error',
          response['data']['message'] ?? 'Failed to delete post',
        );
      }
    } catch (e) {
      showErrorSnackbar('Error', 'Failed to delete post: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showErrorSnackbar(String title, dynamic message) {
    Get.snackbar(
      title,
      message?.toString() ?? 'Something went wrong.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
    );
  }

  Future<void> fetchComments(int postId) async {
    try {
      isLoading.value = true;
      final response = await _apiService.callApi(
        endpoint: '/all-comments-in-post/$postId',
        method: 'GET',
      );
      if (response['statusCode'] == 200 &&
          response['data'] != null &&
          response['data']['data'] != null) {
        final commentResponse = AllComment.fromJson(response['data']);
        comments.assignAll(commentResponse.data);
        print('Comments loaded: ${comments.length}');
      } else {
        comments.clear();
        Get.snackbar(
          'Error',
          response['data']['message'] ?? 'No comments found.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      comments.clear();
      Get.snackbar(
        'Error',
        'Failed to fetch comments: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> commentOnPost(
    String postId,
    String commentText,
    String postedBy,
  ) async {
    try {
      isLoading.value = true;
      final postIdInt = int.tryParse(postId);
      final postedByInt = int.tryParse(postedBy);
      if (postIdInt == null || postedByInt == null) {
        Get.snackbar(
          'Error',
          'Invalid Post ID or PostedBy ID',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.commentOnPost,
        method: 'POST',
        body: {
          'post_id': postIdInt.toString(),
          'comment': commentText,
          'posted_by': postedByInt.toString(),
        },
      );
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        final data = response['data'] as Map<String, dynamic>;
        final commentResponse = CommentResponse.fromJson(data);
        showSuccessSnackbar('Success', commentResponse.message);
        await fetchComments(postIdInt);
      } else {
        Get.snackbar(
          'Error',
          response['data']['message'] ?? 'Failed to post comment',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      showErrorSnackbar('Error', 'Failed to post comment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
