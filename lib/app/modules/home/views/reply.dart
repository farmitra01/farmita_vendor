import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/reply_controller.dart';
import 'package:farmitra/app/modules/home/views/Appointment_Details.dart';
import 'package:farmitra/app/modules/home/views/suggest_product.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Reply extends StatelessWidget {
  const Reply({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with a unique tag
    final ReplyController replyController = Get.put(
      ReplyController(),
      tag: 'ReplyController',
    );
    // Safely handle Get.arguments
    final Map<String, dynamic> arguments = Get.arguments ?? {};
    final Map<String, dynamic> appointmentData = arguments['appointment'] ?? {};
    final int globalIndex = arguments['globalIndex'] ?? -1;
    final int tabIndex = arguments['tabIndex'] ?? -1;
    return Scaffold(
      appBar: const VendorAppBar(title: 'Reply'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                tilePadding: const EdgeInsets.all(0),
                shape: const Border(),
                title: Row(
                  children: [
                    Text(
                      'Wheat',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '01 Apr 25, 13:09',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 80,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                        ),
                        items:
                            replyController.imagePaths.map((imagePath) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.error),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightGrey,
                        ),
                        child: Center(
                          child: Text(
                            'Reddish - brown pustules on a wheat stem will turn black as it decays',
                            style: GoogleFonts.montserrat(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const AppointmentDetails(),
                    arguments: {
                       'appointment': appointmentData,
                                          'globalIndex': globalIndex,
                                          'tabIndex': tabIndex,
                    }
                    );
                  },
                  child:  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Suggest Product',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    // final productIndex = controller.selectedProducts.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/suggetedProductImage.webp',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Product Name',
                            style: GoogleFonts.montserrat(fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          Obx(() {
                            return replyController.quantities[index] == 0
                                ? CustomGradientButton(
                                  text: 'BUY',
                                  width: 80,
                                  height: 30,
                                  onPressed: () {
                                    replyController.incrementQuantity(index);
                                  },
                                )
                                : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 30,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            replyController.decrementQuantity(
                                              index,
                                            );
                                            if (replyController
                                                    .quantities[index] ==
                                                0) {}
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color:
                                                AppColors
                                                    .primaryGradinatMixColor,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          '${replyController.quantities[index]}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppColors
                                                    .primaryGradinatMixColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 30,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed:
                                              () => replyController
                                                  .incrementQuantity(index),
                                          icon: Icon(
                                            Icons.add,
                                            color:
                                                AppColors
                                                    .primaryGradinatMixColor,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Enter Reply Here...',
                keyboardType: TextInputType.text,
                controller: replyController.reply,
                borderRadius: 10,
                maxLines: 5,
                maxLength: 250,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a reply';
                  }
                  if (value.trim().length > 250) {
                    return 'Reply cannot exceed 250 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showImagePickerDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                        color: AppColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            if (replyController.selectedFile.value != null) {
                              switch (replyController.fileType.value) {
                                case UploadType.image:
                                  return Image.file(
                                    replyController.selectedFile.value!,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  );
                                case UploadType.pdf:
                                  return Column(
                                    children: [
                                      const Icon(
                                        Icons.picture_as_pdf,
                                        size: 60,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'PDF Selected',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  );
                                case UploadType.video:
                                  return Obx(() {
                                    final videoController =
                                        replyController.videoController.value;
                                    if (videoController != null &&
                                        videoController.value.isInitialized) {
                                      return SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: VideoPlayer(videoController),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  });
                                default:
                                  return const SizedBox.shrink();
                              }
                            } else {
                              return SvgPicture.asset(
                                'assets/icons/uploadicon.svg',
                                height: 24,
                              );
                            }
                          }),
                          Obx(() {
                            return replyController.selectedFile.value == null
                                ? Text(
                                  'Upload Selected Document',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                                : const SizedBox.shrink();
                          }),
                          Obx(() {
                            return replyController.selectedFile.value == null
                                ? Text(
                                  'JPEG, PNG less than 5MB',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                )
                                : const SizedBox.shrink();
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        CustomGradientButton(
                          gradientColors: [AppColors.yellow, AppColors.yellow],
                          height: 38,
                          text: 'Suggest Product',
                          onPressed: () {
                            Get.to(() => const SuggestProduct());
                          },
                          borderRadius: 10,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  replyController.pickPDF();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient:  LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.primaryFirstGradiant,
                                        AppColors.primarySecondGradiant,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.picture_as_pdf,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  replyController.pickVideo();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient:  LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.primaryFirstGradiant,
                                        AppColors.primarySecondGradiant,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomGradientButton(
                text: 'Send Reply',
                onPressed: () {
                  if (replyController.reply.text.trim().isEmpty) {
                    Get.snackbar('Error', 'Please enter a reply');
                    return;
                  }
                  Get.snackbar('Success', 'Reply sent');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Image:',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGradinatMixColor,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.find<ReplyController>(
                      tag: 'ReplyController',
                    ).pickImage(ImageSource.camera);
                  },
                  child: Text(
                    'Camera',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.find<ReplyController>(
                      tag: 'ReplyController',
                    ).pickImage(ImageSource.gallery);
                  },
                  child: Text(
                    'Gallery',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
