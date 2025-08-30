import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/news_details_controller.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsDetailsController newsDetailsController = Get.put(
      NewsDetailsController(),
    );
    final int? id = Get.arguments as int?;
    if (id != null) {
      newsDetailsController.fetchBlogDetails(
        id,
      ); // Trigger once from passed argument
    }

    return Scaffold(
      appBar: VendorAppBar(title: 'News Details'),
      body: Obx(() {
        if (newsDetailsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final blog = newsDetailsController.blog.value;
        final related = newsDetailsController.relatedBlogs;

        if (blog == null) {
          return const Center(child: Text("Blog not found"));
        }

        final videoId =
            blog.videoLink != null
                ? YoutubePlayer.convertUrlToId(blog.videoLink!)
                : null;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(
                  newsDetailsController.getFullImageUrl(blog.banner),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, _) =>
                          Image.asset('assets/images/fallback.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                         CircleAvatar(
                          backgroundColor: AppColors.primaryGradinatMixColor,
                          child: Icon(
                            Icons.person_2_outlined,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By ${blog.user.name}',
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _formatDate(blog.createdAt),
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.bookmark_added_outlined,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.share, color: AppColors.secondary),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Html(
                      data: blog.content ?? '',
                      style: {
                        "body": Style(
                          fontSize: FontSize(12.0),
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                        ),
                      },
                    ),
                    const SizedBox(height: 20),
                    if (videoId != null)
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: const YoutubePlayerFlags(autoPlay: false),
                        ),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: AppColors.textPrimary,
                        width: double.infinity,
                      ),
                    const SizedBox(height: 20),
                    if (related.isNotEmpty)
                      Text(
                        'Related Articles',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                  ],
                ),
              ),
              if (related.isNotEmpty)
                SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: related.length,
                    itemBuilder: (context, index) {
                      final item = related[index];
                      return InkWell(
                        onTap: () {
                          newsDetailsController.fetchBlogDetails(
                            item.id,
                          ); // ✅ update on tap
                        },
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                newsDetailsController.getFullImageUrl(
                                  item.banner,
                                ),
                                height: 80,
                                width: 120,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, _) =>
                                        const Icon(Icons.image),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  String _formatDate(String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    } catch (_) {
      return rawDate;
    }
  }
}
