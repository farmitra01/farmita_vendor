import 'dart:io';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/views/RetailerStoreDetailsFrom1.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
// import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  RegistrationView({super.key});

  final RegistrationController controller = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    print('crusel list ${controller.mediaList.length}');
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Future.microtask(() async {
            final shouldExit =
                await Get.dialog<bool>(
                  AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to close the app?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Get.back(result: true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ) ??
                false;

            if (shouldExit) {
              SystemNavigator.pop();
            }
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: false,
          onHelpTap: () {
            Get.toNamed('/help-center');
          },
          onTranslateTap: () {
            Get.toNamed('/add');
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchRegistrationMedia();
            await Future.delayed(Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Obx(() {
                  final mediaList = controller.mediaList;
                  return Stack(
                    children: [
                      FlutterCarousel(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: !controller.isVideoPlaying.value,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.5,
                          onPageChanged: (index, reason) {
                            controller.currentIndex.value = index;
                          },
                          showIndicator: false,
                        ),
                        items:
                            mediaList.isEmpty
                                ? [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // border: Border.all(color: Colors.grey),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No media available",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]
                                : List.generate(mediaList.length, (index) {
                                  final media = mediaList[index];
                                  final ytController =
                                      controller.youtubeControllers[index];
                                  final isVideo =
                                      media.videoLink?.isNotEmpty == true;
                                  final isImage =
                                      media.mediaUrl?.isNotEmpty == true;
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        // border: Border.all(color: Colors.grey),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:
                                            isVideo
                                                ? YoutubePlayerBuilder(
                                                  player: YoutubePlayer(
                                                    actionsPadding:
                                                        EdgeInsets.all(0),
                                                    controller: ytController,
                                                    showVideoProgressIndicator:
                                                        true,
                                                    onReady: () {
                                                      ytController.addListener(() {
                                                        final isPlaying =
                                                            ytController
                                                                .value
                                                                .isPlaying;
                                                        if (controller
                                                                .isVideoPlaying
                                                                .value !=
                                                            isPlaying) {
                                                          controller
                                                              .isVideoPlaying
                                                              .value = isPlaying;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  builder:
                                                      (context, player) =>
                                                          player,
                                                )
                                                : isImage
                                                ? Image.network(
                                                  media.mediaUrl ?? "",
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        _,
                                                        __,
                                                        ___,
                                                      ) => Image.asset(
                                                        'assets/images/registration_banner_02.jpg',
                                                      ),
                                                )
                                                : Center(
                                                  child: Text(
                                                    "Media not available",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                        ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  );
                                }),
                      ),

                      /// ✅ PDF Download button shown only if mediaList is not empty AND pdfTitle is valid
                      if (mediaList.isNotEmpty)
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Obx(() {
                            final index = controller.currentIndex.value;
                            final pdfTitle =
                                (mediaList.isNotEmpty &&
                                        index < mediaList.length)
                                    ? mediaList[index].pdfTitle
                                    : null;

                            // ✅ Hide container completely if title is null or empty
                            if (pdfTitle == null || pdfTitle.trim().isEmpty) {
                              return SizedBox.shrink();
                            }

                            return GestureDetector(
                              onTap: () async {
                                final currentMedia = mediaList[index];
                                final pdfUrl = currentMedia.pdfLink;
                                if (pdfUrl != null && pdfUrl.isNotEmpty) {
                                  final Uri uri = Uri.parse(pdfUrl);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Could not open PDF link',
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    'Unavailable',
                                    'PDF not found for this slide',
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.lightGrey,
                                ),
                                child: Text(
                                  pdfTitle,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                    ],
                  );
                }),
                SizedBox(height: 8),

                /// ✅ Outside indicator
                Obx(() {
                  final mediaList = controller.mediaList;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(mediaList.length, (index) {
                      final isActive = controller.currentIndex.value == index;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        width: isActive ? 10 : 8,
                        height: isActive ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              isActive
                                  ? AppColors.primaryGradinatMixColor
                                  : Colors.grey,
                        ),
                      );
                    }),
                  );
                }),

                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback:
                            (bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryFirstGradiant,
                                AppColors.primarySecondGradiant,
                              ],
                            ).createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                        child: Text(
                          'Let’s get started:',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '    Steps to register-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            // Use Obx to rebuild the stepper when the currentStep changes
                            return Column(
                              children: [
                                for (int index = 0; index < 4; index++) ...[
                                  _buildStep(index),
                                  if (index < 3) _buildConnector(index),
                                ],
                              ],
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomGradientButton(
                        text: 'Register Now!',
                        onPressed: () {
                          Get.toNamed('/store-details');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildStep(int stepIndex) {
  final RegistrationController controller = Get.find();

  return GestureDetector(
    onTap: () {
      controller.setStep(stepIndex);
      switch (stepIndex) {
        case 0:
          Get.to(() => RetailerStoreDetailsFrom1());
          break;
        case 1:
          Get.to(() => RentalKyc());
          break;
        case 2:
          Get.toNamed('/business_kyc');
          break;
        case 3:
          Get.toNamed('/bank-details');
          break;
      }
    },
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                controller.currentStep.value == stepIndex
                    ? AppColors.primaryGradinatMixColor
                    : Colors.transparent,
            border: Border.all(
              color:
                  controller.currentStep.value == stepIndex
                      ? AppColors.primaryGradinatMixColor
                      : AppColors.secondary,
              width: 2,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              controller.stepperContent[stepIndex].imagePath,
              color:
                  controller.currentStep.value == stepIndex
                      ? AppColors.white
                      : AppColors.secondary,
            ),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.stepperContent[stepIndex].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    controller.currentStep.value == stepIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                color:
                    controller.currentStep.value == stepIndex
                        ? AppColors.primaryGradinatMixColor
                        : AppColors.secondary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              controller.stepperContent[stepIndex].subtitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    controller.currentStep.value == stepIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    ),
  );
}

Widget _buildConnector(int index) {
  final RegistrationController controller = Get.put(RegistrationController());

  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      margin: EdgeInsets.only(left: 20), // Adjust as needed
      width: 2,
      height: 20, // Adjust based on your design
      color: AppColors.secondary,
    ),
  );
}
