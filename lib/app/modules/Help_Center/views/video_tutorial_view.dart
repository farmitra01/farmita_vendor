import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTutorialView extends GetView {
  const VideoTutorialView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> videoIds = [
      'PJvd6kRnMVM',
      'bcZYScJqgkw',
      '3FcBh45t9Vs',
      '9nIPSOCIUyU',
      'vnQfAYGIVCY',

      // Add up to 12 video IDs
    ];
    return Scaffold(
      appBar: VendorAppBar(title: 'Video Tutorial'),
      body: ListView.builder(
        itemCount: videoIds.length,
        itemBuilder: (context, index) { 
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoIds[index],
                    flags: YoutubePlayerFlags(autoPlay: false, mute: false),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                ),
                SizedBox(height: 10),
                Text(
                  'How to register as vendor? | First time on-boarding tutorial of First find | First Find vendor.',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
