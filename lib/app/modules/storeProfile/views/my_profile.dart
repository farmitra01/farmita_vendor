import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/ApiModels/getPost.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/my_profile_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileController myProfileController = Get.put(
      MyProfileController(),
    );
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: VendorAppBar(
        title: 'My Profile',
        actions: [
          Row(
            children: [
              Icon(Icons.shopping_cart, color: AppColors.white),
              SizedBox(width: 15),
              Icon(Icons.notifications_active, color: AppColors.white),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(color: AppColors.appBarColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundColor: AppColors.white, radius: 35),
                    SizedBox(width: 10),
                    Row(
                      children: List.generate(
                        myProfileController.profileDetail.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              Text(
                                myProfileController
                                    .profileDetail[index]['count'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(height: 1.5),
                              Text(
                                myProfileController
                                    .profileDetail[index]['details'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'Raj Rathod',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '8737055521',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Noida Uttar Pradesh',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          // Tab Bar
          TabBar(
            labelColor: AppColors.primaryGradinatMixColor,
            indicatorColor: AppColors.primaryGradinatMixColor,
            controller: myProfileController.tabController,
            tabs: [Tab(text: 'My Post'), Tab(text: 'Saved Posts')],
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: myProfileController.tabController,
              children: [buildScrollablePosts(), buildSavedPosts()],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildScrollablePosts() {
  final MyProfileController myProfileController =
      Get.find<MyProfileController>();
  return Obx(() {
    if (myProfileController.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryGradinatMixColor,
        ),
      );
    }
    if (myProfileController.posts.isEmpty) {
      return const Center(child: Text('No posts available'));
    }
    return ListView.builder(
      physics: BouncingScrollPhysics(), // Enable scrolling
      shrinkWrap: true, // Take only needed space
      itemCount: myProfileController.posts.length,
      itemBuilder:
          (context, index) =>
              buildMyPost(context, myProfileController.posts[index]),
    );
  });
}

Widget buildMyPost(BuildContext context, Post post) {
  final MyProfileController myProfileController =
      Get.find<MyProfileController>();
  final imageUrls = myProfileController.getImageUrlsForPost(post.id);

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
                   case 'Delete':
                    myProfileController.deletePost(post.id);
                    break;
                }
              },
              itemBuilder:
                  (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
                    ),
                  ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (imageUrls.isNotEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: CarouselSlider(
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
            ),
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
                myProfileController.action.asMap().entries.map((entry) {
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

Widget buildSavedPosts() {
  final MyProfileController myProfileController =
      Get.find<MyProfileController>();
  return Obx(() {
    if (myProfileController.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryGradinatMixColor,
        ),
      );
    }
    // Placeholder for saved posts; update with actual implementation when available
    return ListView(
      physics: BouncingScrollPhysics(), // Enable scrolling
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Saved Posts Will be Available Soon...!',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  });
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
  final MyProfileController myProfileController =
      Get.find<MyProfileController>();
  bool hasFetchedComments = false;

  // Fetch comments only once
  if (!hasFetchedComments) {
    hasFetchedComments = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (myProfileController.comments.isEmpty) {
        final id = int.tryParse(postId);
        if (id != null) {
          myProfileController.fetchComments(id);
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
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
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
                      myProfileController.isLoading.value
                          ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          )
                          : myProfileController.comments.isEmpty
                          ? const Center(child: Text("No comments yet."))
                          : ListView.builder(
                            controller: scrollController,
                            itemCount: myProfileController.comments.length,
                            itemBuilder: (context, index) {
                              final comment =
                                  myProfileController.comments[index];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        controller: myProfileController.reply,
                        validator: (p0) => null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child:
                          myProfileController.isLoading.value
                              ? CircularProgressIndicator(
                                color: AppColors.primaryGradinatMixColor,
                              )
                              : IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () async {
                                  if (myProfileController.reply.text
                                      .trim()
                                      .isNotEmpty) {
                                    final commentText =
                                        myProfileController.reply.text.trim();
                                    await myProfileController.commentOnPost(
                                      postId,
                                      commentText,
                                      postedBy,
                                    );
                                    myProfileController.reply.clear();
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
