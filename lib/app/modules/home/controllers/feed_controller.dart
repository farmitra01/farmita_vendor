import 'dart:convert';
import 'package:farmitra/app/ApiModels/get-blog.dart';
import 'package:farmitra/app/ApiModels/getAllComment.dart';
import 'package:farmitra/app/ApiModels/getPost.dart';
import 'package:farmitra/app/ApiModels/postComment.dart';
import 'package:farmitra/app/ApiModels/postReport.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/remote/remote_api.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeedController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final count = 0.obs;
  final isLoading = false.obs;
  final search = TextEditingController();
  final reply = TextEditingController();
  final report = TextEditingController();
  final RxInt reportCharCount = 0.obs;
  bool _hasFetchedComments = false;

  final List<Map<String, dynamic>> action = [
    {'icon': Icons.favorite_outline_outlined, 'count': '45'},
    {'icon': Icons.chat, 'count': '5'},
    {'icon': Icons.bookmark_add, 'count': '10'},
    {'icon': Icons.share, 'count': '15'},
  ];

  final List<String> imagePaths = [
    'assets/images/damage_leaves_01.jpg',
    'assets/images/damage_leaves_02.jpg',
    'assets/images/damage_leaves_03.jpg',
  ];

  RxList<Post> posts = <Post>[].obs;
  RxList<Map<String, dynamic>> videos = <Map<String, dynamic>>[].obs;
  RxList<bool> isVideoPlaying = <bool>[].obs;
  RxList<BlogPost> blogs = <BlogPost>[].obs;
  var comments = <CommentModel>[].obs;

  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  final String _baseImageUrl = 'https://api.farmitra.in/storage/';
  final Map<int, YoutubePlayerController> _videoControllers = {};

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabChange);
    fetchPosts();
    fetchBlogs();
    report.addListener(() {
      reportCharCount.value = report.text.length;
    });
  }

  @override
  void onClose() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    search.dispose();
    reply.dispose();
    report.dispose();
    _disposeVideoControllers();
    super.onClose();
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
        comments.assignAll(commentResponse.data); // ✔️ now this works
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
  Future<void> reportPost(String postId, String postedBy) async {
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
        endpoint: ApiEndpoints.reportPost,
        method: 'POST',
        body: {
          'post_id': postIdInt.toString(),
          'posted_by': postedByInt.toString(),
          'reason': report.text,
        },
      );
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        final responseData = response['data'] as Map<String, dynamic>;
        final reportResponse = ReportPostResponse.fromJson(responseData);
        showErrorSnackbar(
          'Error',
          response['data']['message'] ?? 'Failed to submit report',
        );
        report.clear();
        Get.back();
        ();
      } else {
        Get.snackbar(
          'Error',
          response['data']['message'] ?? 'Failed to submit report',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit report: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  void clearReport() {
    report.clear();
    reportCharCount.value = 0;
  }
  void _handleTabChange() {
    print('Tab changed to index: ${tabController.index}');
    if (!tabController.indexIsChanging) {
      if (tabController.index == 0) {
        fetchPosts();
      } else if (tabController.index == 1) {
        fetchPostedVideo();
      } else if (tabController.index == 2) {
        fetchBlogs();
      }
    }
  }

  Future<void> fetchBlogs() async {
    try {
      isLoading.value = true;
      print('Fetching blogs from /get-blogs');

      final response = await _apiService.callApi(
        endpoint: '/get-blogs',
        method: 'GET',
      );

      if (response['statusCode'] == 200 && response['data'] != null) {
        final responseData = response['data'];
        if (responseData['status'] == true) {
          final blogListData = responseData['data'];
          if (blogListData is Map<String, dynamic> &&
              blogListData['data'] is List) {
            final blogItems = blogListData['data'] as List;
            print('Blog items count: ${blogItems.length}');
            final parsedBlogs =
                blogItems
                    .map(
                      (item) =>
                          item is Map<String, dynamic>
                              ? BlogPost.fromJson(item)
                              : null,
                    )
                    .whereType<BlogPost>()
                    .toList();
            blogs.assignAll(parsedBlogs);
            print(
              'Blogs parsed: count=${blogs.length}, titles=${blogs.map((b) => b.title).toList()}',
            );
          } else {
            print('Invalid blog list data: $blogListData');
            blogs.clear();
            Get.snackbar('Error', 'Invalid blog data format');
          }
        } else {
          print('API status false: ${responseData['message'] ?? 'No message'}');
          blogs.clear();
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to fetch blogs',
          );
        }
      } else {
        print('Invalid API response: statusCode=${response['statusCode']}');
        blogs.clear();
        Get.snackbar('Error', 'Failed to fetch blogs');
      }
    } catch (e, stackTrace) {
      print('Error in fetchBlogs: $e\n$stackTrace');
      blogs.clear();
      Get.snackbar('Error', 'Failed to fetch blogs: $e');
    } finally {
      isLoading.value = false;
      blogs.refresh();
    }
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.getPost,
        method: 'GET',
      );
      if (response['data']['success'] == true) {
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

  Future<void> fetchPostedVideo() async {
    try {
      isLoading.value = true;
      print('Fetching videos from ${ApiEndpoints.getpostvideo}');

      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.getpostvideo,
        method: 'GET',
      );
      print('response["data"] type: ${response['data'].runtimeType}');

      if (response['data']['success'] == true &&
          response['data'] is Map<String, dynamic>) {
        final Map<String, dynamic> nestedData = response['data'];
        final videoData = nestedData['data'];
        if (videoData is List) {
          final parsedVideos =
              videoData
                  .map<Map<String, dynamic>>(
                    (e) => Map<String, dynamic>.from(e),
                  )
                  .toList();

          videos.clear();
          videos.addAll(parsedVideos);
          isVideoPlaying.clear();
          isVideoPlaying.addAll(List.filled(parsedVideos.length, false));
          print('Videos assigned: ${videos.length} videos');
        } else {
          print(
            'Expected a List in response["data"]["data"], got ${videoData.runtimeType}',
          );
          Get.snackbar('Error', 'Video data format is invalid.');
        }
      } else {
        print('API success false or data missing');
        Get.snackbar(
          'Error',
          response['data']['message'] ?? 'Failed to fetch videos',
        );
      }
    } catch (e, stackTrace) {
      print('Error in fetchPostedVideo: $e\n$stackTrace');
      Get.snackbar('Error', 'Failed to fetch videos: $e');
    } finally {
      isLoading.value = false;
      videos.refresh();
      print('Final videos list length: ${videos.length}');
    }
  }

  List<String> getImageUrlsForPost(int postId) {
    final post = posts.firstWhereOrNull((post) => post.id == postId);
    return post?.postImages
            .map((image) => '$_baseImageUrl${image.image}')
            .toList() ??
        [];
  }

  String getThumbnailUrl(String thumbnail) {
    return thumbnail.isNotEmpty
        ? '$_baseImageUrl$thumbnail'
        : 'https://via.placeholder.com/150';
  }

  YoutubePlayerController getVideoController(int index) {
    if (!_videoControllers.containsKey(index)) {
      final videoId = YoutubePlayer.convertUrlToId(
        videos[index]['video_link'] ?? '',
      );
      if (videoId != null) {
        _videoControllers[index] = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      } else {
        print(
          'Invalid video ID for index $index: ${videos[index]['video_link']}',
        );
      }
    }
    return _videoControllers[index]!;
  }

  void toggleVideoPlay(int index) {
    if (index >= 0 && index < videos.length) {
      isVideoPlaying[index] = !isVideoPlaying[index];
      final controller = getVideoController(index);
      if (isVideoPlaying[index]) {
        controller.play();
      } else {
        controller.pause();
      }
      isVideoPlaying.refresh();
    } else {
      print('Invalid video index: $index');
    }
  }

  void _disposeVideoControllers() {
    _videoControllers.forEach((_, controller) {
      controller.dispose();
    });
    _videoControllers.clear();
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
}
