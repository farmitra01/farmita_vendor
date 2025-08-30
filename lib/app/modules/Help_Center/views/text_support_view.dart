import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Help_Center/controllers/text_support_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TextSupportView extends GetView {
  const TextSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextSupportController textSupportController = Get.put(
      TextSupportController(),
    );

    return Scaffold(
      appBar: VendorAppBar(
        title: 'Chat',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () => Get.toNamed('/ticket'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    // Optional SVG icon can be added here
                    const SizedBox(width: 5),
                    Text(
                      'My Ticket',
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
      body: Obx(() {
        if (textSupportController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryGradinatMixColor,
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please Select the issue from given categories',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomDropdown<String>(
                    hint: 'Categories',
                    items:
                        textSupportController.grievancesCategoryList
                            .map((category) => category.name)
                            .toList(),
                    selectedItem:
                        textSupportController.selectedItem.value.isEmpty
                            ? null
                            : textSupportController.selectedItem.value,
                    onChanged: (value) {
                      textSupportController.updatedSelectedValue(value ?? '');
                    },
                    itemBuilder: (item) => item,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  borderRadius: 5,
                  hintText: 'Enter Text Here...',
                  keyboardType: TextInputType.text,
                  controller: textSupportController.entertext,
                  maxLines: 5,
                  maxLength: 200,
                  validator: (value) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => Text(
                        '${textSupportController.wordCount.value}/250',

                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () => _showImagePickerDialog(),
                  child: Center(
                    child: DottedBorder(
                      color: AppColors.border,
                      dashPattern: [6, 3],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      child: Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                        ),
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textSupportController.selectedImage.value != null
                                  ? Image.file(
                                    textSupportController.selectedImage.value!,
                                    height: 100,
                                    width: 125,
                                    fit: BoxFit.fill,
                                  )
                                  : SvgPicture.asset(
                                    'assets/icons/uploadicon.svg',
                                  ),
                              textSupportController.selectedImage.value == null
                                  ? Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        'Upload Document',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'JPEG, PNG less than 5MB',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: CustomGradientButton(
          text: 'Submit',
          onPressed: () {
            if (textSupportController.validateDropdown() &&
                textSupportController.entertext.text.trim().isNotEmpty) {
              textSupportController.submitGrievance();
              if (textSupportController.isLoading.value == true) {
                textSupportController.selectedItem.value = '';
                textSupportController.entertext.clear();
                textSupportController.selectedImage.value = null;
              }
            } else {
              Get.snackbar(
                'Validation Error',
                'Please fill all required fields',
              );
            }
          },
        ),
      ),
    );
  }
}

void _showImagePickerDialog() {
  final TextSupportController textSupportController = Get.find();

  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Select Image:-',
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
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  ();
                  textSupportController.pickImage(ImageSource.camera);
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
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  ();
                  textSupportController.pickImage(ImageSource.gallery);
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
