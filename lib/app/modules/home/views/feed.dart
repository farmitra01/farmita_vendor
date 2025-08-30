// lib/modules/home/views/feed.dart
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/ApiModels/getAllComment.dart';
import 'package:farmitra/app/ApiModels/getPost.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/feed_controller.dart';
import 'package:farmitra/app/modules/home/views/add_post.dart';
import 'package:farmitra/app/modules/home/views/news_details.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedController feedController = Get.put(FeedController());

    return Scaffold(
      appBar: VendorAppBar(title: 'Feed'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: CustomTextFormField(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primaryGradinatMixColor,
              ),
              hintText: 'Search in Feed',
              keyboardType: TextInputType.text,
              controller: feedController.search,
              validator: (p0) => null,
              suffixWidget: Icon(
                Icons.mic,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ),
          TabBar(
            dividerColor: AppColors.secondary,
            indicatorColor: AppColors.primaryGradinatMixColor,
            indicatorWeight: 4.0,
            labelColor: AppColors.primaryGradinatMixColor,
            controller: feedController.tabController,
            labelStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Videos'),
              Tab(text: 'News'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: feedController.tabController,
              children: [buildScrollablePosts(), buildVideo(), buildNews()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_post',
        onPressed: () {
          Get.to(() => const AddPost());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryGradinatMixColor,
          ),
          child: const Center(
            child: Icon(Icons.message_rounded, color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget buildScrollablePosts() {
    final FeedController feedController = Get.find<FeedController>();
    return Obx(() {
      if (feedController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryGradinatMixColor,
          ),
        );
      }
      if (feedController.posts.isEmpty) {
        return const Center(child: Text('No posts available'));
      }
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: feedController.posts.length,
        itemBuilder:
            (context, index) => buildPost(context, feedController.posts[index]),
      );
    });
  }

  Widget buildPost(BuildContext context, Post post) {
    final FeedController feedController = Get.find<FeedController>();
    final imageUrls = feedController.getImageUrlsForPost(post.id);

    // Determine if profile picture is valid
    final bool hasValidProfilePicture =
        post.postedBy.profilePicture != null &&
        post.postedBy.profilePicture!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow( 
            blurRadius: 2.5,
            color: AppColors.containerShadowColor,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: AppColors.primaryGradinatMixColor,
                radius: 25,
                backgroundImage:
                    hasValidProfilePicture
                        ? NetworkImage(
                          'https://api.farmitra.in/storage/${post.postedBy.profilePicture}',
                        )
                        : null,
                onBackgroundImageError:
                    hasValidProfilePicture
                        ? (exception, stackTrace) {
                          print(
                            'Error loading profile picture for ${post.postedBy.name}: $exception',
                          );
                        }
                        : null,
                child:
                    hasValidProfilePicture
                        ? null
                        : const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.postedBy.name.isEmpty
                              ? 'Unknown'
                              : post.postedBy.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () => print('Follow tapped'),
                          child: Text(
                            'follow',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      post.location.isEmpty ? 'Unknown' : post.location,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      _formatDateTime(post.createdAt),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'Unfollow':
                      print('Unfollow tapped');
                      break;
                    case 'Block':
                      print('Block tapped');
                      break;
                    case 'Report':
                      print('Report tapped');
                      showDialog(
                        context: context,
                        builder:
                            (context) => buildReportDialog(
                              context,
                              post.postId.toString(),
                              post.userId.toString(),
                            ),
                      );
                      break;
                  }
                },
                itemBuilder:
                    (BuildContext context) => [
                      const PopupMenuItem<String>(
                        value: 'Unfollow',
                        child: Text('Unfollow'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Block',
                        child: Text('Block'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Report',
                        child: Text('Report'),
                      ),
                    ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (imageUrls.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.3,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                enableInfiniteScroll: imageUrls.length > 1,
              ),
              items:
                  imageUrls.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            _showImageDialog(
                              context,
                              imageUrls,
                              imageUrls.indexOf(url),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryGradinatMixColor,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  print(
                                    'Error loading carousel image $url: $error',
                                  );
                                  return const Center(
                                    child: Icon(Icons.broken_image, size: 50),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            )
          else
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text(
                  'No images available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              post.content.isEmpty ? 'No description' : post.content,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  feedController.action.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final action = entry.value;
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            _showBottomSheet(context, _buildLikeSheet(post));
                            break;
                          case 1:
                            _showBottomSheet(
                              context,
                              _buildCommentSheet(
                                context,
                                post.postId.toString(),
                                post.postedBy.toString(),
                              ),
                            );
                            break;
                          default:
                            print('Action $index tapped');
                            break;
                        }
                      },
                      child: Row(
                        children: [
                          Icon(action['icon'], color: AppColors.secondary),
                          const SizedBox(width: 5),
                          Text(
                            index == 0
                                ? post.totalLikes.toString()
                                : index == 1
                                ? post.totalComments.toString()
                                : action['count'].toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVideo() {
    final FeedController feedController = Get.find<FeedController>();

    return Obx(() {
      if (feedController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryGradinatMixColor,
          ),
        );
      }
      if (feedController.videos.isEmpty) {
        return const Center(child: Text('No videos available'));
      }
      return ListView.builder(
        itemCount: feedController.videos.length,
        itemBuilder: (context, index) {
          final video = feedController.videos[index];
          final videoId = YoutubePlayer.convertUrlToId(
            video['video_link'] ?? '',
          );
          final List<dynamic> tags =
              (() {
                try {
                  final raw = video['tags'];
                  if (raw is List) return raw;
                  if (raw is String) {
                    final parsed = jsonDecode(raw);
                    return parsed is List ? parsed : [];
                  }
                  return [];
                } catch (e) {
                  print('Tag parsing error: $e');
                  return [];
                }
              })();

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.containerShadowColor,
                  blurRadius: 2.5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primaryGradinatMixColor,
                      backgroundImage:
                          (video['user']?['profile_picture']?.isNotEmpty ??
                                  false)
                              ? NetworkImage(
                                'https://api.farmitra.in/storage/${video['user']['profile_picture']}',
                              )
                              : null,
                      child:
                          (video['user']?['profile_picture']?.isEmpty ?? true)
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                video['user']?['name']?.isEmpty ?? true
                                    ? 'Unknown'
                                    : video['user']['name'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => print('Follow tapped'),
                                child: Text(
                                  'Follow',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            video['location']?.isEmpty ?? true
                                ? 'Unknown'
                                : video['location'],
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            _formatDateTime(video['created_at'] ?? ''),
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        print('Selected: $value');
                        if (value == 'Report') {
                          showDialog(
                            context: context,
                            builder:
                                (context) => buildReportDialog(
                                  context,
                                  video['id'].toString(),
                                  video['user']['id'].toString(),
                                ),
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                            const PopupMenuItem(
                              value: 'Unfollow',
                              child: Text('Unfollow'),
                            ),
                            const PopupMenuItem(
                              value: 'Block',
                              child: Text('Block'),
                            ),
                            const PopupMenuItem(
                              value: 'Report',
                              child: Text('Report'),
                            ),
                          ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (tags.isNotEmpty)
                  Wrap(
                    spacing: 5,
                    children:
                        tags.map((tag) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.yellow.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: AppColors.yellow,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                const SizedBox(height: 10),
                Obx(() {
                  if (videoId == null) {
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(child: Text('Invalid video URL')),
                    );
                  }
                  return GestureDetector(
                    onTap: () => feedController.toggleVideoPlay(index),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        feedController.isVideoPlaying[index]
                            ? YoutubePlayer(
                              controller: feedController.getVideoController(
                                index,
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor:
                                  AppColors.primaryGradinatMixColor,
                            )
                            : Image.network(
                              feedController.getThumbnailUrl(
                                video['thumbnail'] ?? '',
                              ),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.broken_image),
                                    ),
                                  ),
                            ),
                        if (!feedController.isVideoPlaying[index])
                          const Icon(
                            Icons.play_circle_filled,
                            size: 50,
                            color: Colors.white70,
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Text(
                  video['content']?.isEmpty ?? true
                      ? 'No description'
                      : video['content'],
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      feedController.action.asMap().entries.map((entry) {
                        final int idx = entry.key;
                        final action = entry.value;
                        final count =
                            idx == 0
                                ? (video['total_likes']?.toString() ?? '0')
                                : idx == 1
                                ? (video['total_comments']?.toString() ?? '0')
                                : action['count'].toString();
                        return GestureDetector(
                          onTap: () => print('Tapped action $idx'),
                          child: Row(
                            children: [
                              Icon(action['icon'], color: AppColors.secondary),
                              const SizedBox(width: 5),
                              Text(
                                count,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildNews() {
    final FeedController feedController = Get.find<FeedController>();

    return Obx(() {
      final isLoading = feedController.isLoading.value;
      final blogs = feedController.blogs;

      print(
        'buildNews called: isLoading=$isLoading, blogsCount=${blogs.length}, titles=${blogs.map((b) => b.title).toList()}',
      );

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryGradinatMixColor,
          ),
        );
      }
      if (blogs.isEmpty) {
        return const Center(child: Text('No blogs found'));
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];

          return InkWell(
            onTap: () {
              Get.to(() => const NewsDetails(), arguments: blog.id);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        feedController.getThumbnailUrl(blog.banner),
                        width: 85,
                        height: 85,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, _) =>
                                const Icon(Icons.broken_image, size: 85),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.title.isEmpty ? 'Untitled' : blog.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            blog.user.name.isEmpty ? 'Unknown' : blog.user.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _formatDateTime(blog.createdAt),
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: AppColors.secondary),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildReportDialog(
    BuildContext context,
    String postId,
    String postedBy,
  ) {
    final FeedController feedController = Get.find<FeedController>();

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Report Post',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              feedController.clearReport();
              // Get.closeAllSnackbars();
              Get.back();
              ();
            },
            icon: const Icon(Icons.close_rounded, color: AppColors.error),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            borderRadius: 10,
            maxLines: 3,
            hintText: 'Report Here ...',
            keyboardType: TextInputType.text,
            controller: feedController.report,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a reason';
              }
              if (value.length > 250) {
                return 'Cannot exceed 250 characters';
              }
              return null;
            },
            onChanged: (value) {
              feedController.reportCharCount.value = value.length;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  '${feedController.reportCharCount.value}/250',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                feedController.clearReport();
                Get.back();
              },
              child: Text(
                'Close',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            CustomGradientButton(
              width: 75,
              height: 35,
              text: 'Report',
              onPressed: () {
                if (feedController.report.text.isNotEmpty &&
                    feedController.report.text.length <= 250) {
                  feedController.reportPost(postId, postedBy);
                  print('posted by : $postedBy , postId : $postId');
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a valid reason (max 250 characters)',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDateTime(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy hh:mm a').format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  void _showImageDialog(
    BuildContext context,
    List<String> imageUrls,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.35,
                  initialPage: initialIndex,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                ),
                items:
                    imageUrls.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InteractiveViewer(
                            panEnabled: true,
                            minScale: 1.0,
                            maxScale: 4.0,
                            child: Image.network(
                              url,
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 50),
                            ),
                          );
                        },
                      );
                    }).toList(),
              ),
              CircleAvatar(
                backgroundColor: AppColors.primaryGradinatMixColor,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => child,
    );
  }

  Widget _buildLikeSheet(dynamic item) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Likes",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primaryGradinatMixColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Guest $index',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentSheet(
    BuildContext context,
    String postId,
    String postedBy,
  ) {
    final FeedController feedController = Get.find<FeedController>();
    bool _hasFetchedComments = false;
    // ✅ Safe: only run once
    if (_hasFetchedComments!) {
      _hasFetchedComments = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (feedController.comments.isEmpty) {
          final id = int.tryParse(postId);
          if (id != null) {
            feedController.fetchComments(id);
          }
        }
      });
    }
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return Obx(() {
          return Padding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(
                    context,
                  ).viewInsets.bottom, // Adjust for keyboard
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Comments",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child:
                        feedController.isLoading.value
                            ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            )
                            : feedController.comments.isEmpty
                            ? const Center(child: Text("No comments yet."))
                            : ListView.builder(
                              controller: scrollController,
                              itemCount: feedController.comments.length,
                              itemBuilder: (context, index) {
                                final comment = feedController.comments[index];
                                final createdAt = comment.createdAt;
                                final commentText = comment.comment;
                                final user =
                                    comment.commentedBy.name.isEmpty
                                        ? 'Unknown'
                                        : comment.commentedBy.name;
                                final profileUrl =
                                    comment.commentedBy.profilePicture != null
                                        ? 'https://api.farmitra.in/storage/${comment.commentedBy.profilePicture}'
                                        : null;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            AppColors.primaryGradinatMixColor,
                                        child:
                                            profileUrl != null
                                                ? ClipOval(
                                                  child: Image.network(
                                                    profileUrl,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => const Icon(
                                                          Icons.person,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                )
                                                : const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              commentText,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _formatDateTime(createdAt),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          borderRadius: 10,
                          hintText: 'Enter Reply',
                          keyboardType: TextInputType.text,
                          controller: feedController.reply,
                          validator: (p0) => null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        child:
                            feedController.isLoading.value
                                ? CircularProgressIndicator(
                                  color: AppColors.primaryGradinatMixColor,
                                )
                                : IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () async {
                                    if (feedController.reply.text
                                        .trim()
                                        .isNotEmpty) {
                                      final commentText =
                                          feedController.reply.text.trim();
                                      await feedController.commentOnPost(
                                        postId,
                                        commentText,
                                        postedBy,
                                      );
                                      feedController.reply.clear();
                                    }
                                  },
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
