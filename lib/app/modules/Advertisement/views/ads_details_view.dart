import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Advertisement/controllers/ads_details_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AdsDetailsView extends StatelessWidget {
  const AdsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdsDetailsController adsDetailsController = Get.put(
      AdsDetailsController(),
    );
    return Scaffold(
      appBar: VendorAppBar(title: 'Ads Details  '),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Ads ID #1000003',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Spacer(),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),

                            child: Text(
                              'Expired',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: AppColors.border),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: AppColors.green),
                        SizedBox(width: 10),
                        Text(
                          'Ads Created on',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '08 Aug 2025 05:13 PM ',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: AppColors.green),
                        SizedBox(width: 10),
                        Text(
                          'Duration',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '08 Aug 2025 - 07 May ',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.campaign, color: AppColors.green),
                        SizedBox(width: 10),
                        Text(
                          'Ads Type',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Video Promotion ',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          color: AppColors.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Payment Status',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Paid',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ads Title',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Asian Delights for You',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Discription',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Order ₹100+ worth of Asian cuisine, to get a free delivery treat!',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Video',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        adsDetailsController
                            .pickMediaFiles(); // Open file picker
                      },
                      child: DottedBorder(
                        color: AppColors.border,
                        dashPattern: [6, 3],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        child: Container(
                          // height: 180,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white,
                          ),
                          child: Obx(
                            () =>
                                adsDetailsController.selectedFiles.isEmpty
                                    ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/uploadicon.svg',
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Upload Image or Video',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'JPEG, PNG, MP4, MOV (Max 5MB)',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    )
                                    : Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children:
                                          adsDetailsController.selectedFiles.map((
                                            file,
                                          ) {
                                            final isVideo =
                                                file.path.endsWith('.mp4') ||
                                                file.path.endsWith('.mov');
                                            return Container(
                                              width: double.infinity,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child:
                                                  isVideo
                                                      ? Center(
                                                        child: Icon(
                                                          Icons.videocam,
                                                          size: 40,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                      : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        child: Image.file(
                                                          file,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                            );
                                          }).toList(),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: CustomGradientButton(
                text: 'Delete',
                onPressed: () {},
                gradientColors: [AppColors.error, AppColors.error],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomGradientButton(
                text: 'Duplicate',
                onPressed: () {},
                gradientColors: [
                  AppColors.primaryGradinatMixColor,
                  AppColors.primaryGradinatMixColor,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _showImagePickerDialog() {
//       final AdsDetailsController adsDetailsController = Get.put(AdsDetailsController());

//   showDialog(
//     context: Get.context!, // Since you're using GetX
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(
//           'Select Image:-',
//           style: GoogleFonts.montserrat(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: AppColors.primaryGradinatMixColor,
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min, // To avoid the dialog being too large
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // If you need to add additional content here
//           ],
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Get.back(); // Close dialog
//                   adsDetailsController.(ImageSource.camera);
//                 },
//                 child: Text(
//                   'Camera',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.primaryGradinatMixColor,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Get.back(); // Close dialog
//                   adsDetailsController.pickImage(ImageSource.gallery);
//                 },
//                 child: Text(
//                   'Gallery',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.primaryGradinatMixColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }
