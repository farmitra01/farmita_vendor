import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/models/store_category_model/store_template_model.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_details_form_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StoreDetailsFormView extends StatelessWidget {
  const StoreDetailsFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final StoreLocationController storeLocationController = Get.put(
      StoreLocationController(),
    );
    final StoreDetailsFormController storeDetailsFormController = Get.put(
      StoreDetailsFormController(),
    );
    final StoreCategoryController storeCategoryController = Get.put(
      StoreCategoryController(),
    );

    // final String? logoImagePath = arguments['logoImage'] as String?;
    // final String? bannerImagePath = arguments['bannerImage'] as String?;
    // final StoreTemplateModel? logoTemplate =
    //     arguments['logoTemplate'] as StoreTemplateModel?;
    // final StoreTemplateModel? bannerTemplate =
    //     arguments['bannerTemplate'] as StoreTemplateModel?;
    // final String firstName = arguments['firstName'] as String? ?? 'Farmitra';
    // final String lastName =
    //     arguments['lastName'] as String? ??
    //     storeCategoryController.previousPageGridTitle ??
    //     'Expert';

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        onHelpTap: () => Get.toNamed('/help-center'),
        onTranslateTap: () => Get.toNamed('/add'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Expert Details',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          final logoPath =
                              storeDetailsFormController.selectedLogoPath.value;
                          return GestureDetector(
                            onTap: () {
                              storeDetailsFormController.pickImage('logo');
                            },
                            child: DottedBorder(
                              color: AppColors.secondary,
                              strokeWidth: 1,
                              dashPattern: const [6, 3],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(100),
                              child: Container(
                                height: 125,
                                width: 125,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    logoPath.isNotEmpty
                                        ? ClipOval(
                                          child: Image.file(
                                            File(logoPath),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (_, __, ___) => Image.asset(
                                                  'assets/images/Null_ticket.png',
                                                ),
                                          ),
                                        )
                                        : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/uploadicon.svg',
                                              color: AppColors.secondary,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Upload logo',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'JPEG, PNG less than 5MB',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 10),
                        Text(
                          'Upload your Profile\n       here (1:1)',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    Column(
                      children: [
                        Obx(() {
                          final bannerPath =
                              storeDetailsFormController
                                  .selectedBannerPath
                                  .value;

                          return GestureDetector(
                            onTap: () async {
                              final source =
                                  await storeDetailsFormController
                                      .selectImageSourceDialog();
                              if (source == null) return;
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(
                                source: source,
                                imageQuality: 85,
                              );
                              if (pickedFile != null) {
                                storeDetailsFormController
                                    .selectedBannerPath
                                    .value = pickedFile.path;
                              }
                            },
                            child: DottedBorder(
                              color: AppColors.secondary,
                              strokeWidth: 1,
                              dashPattern: const [6, 3],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              child: Container(
                                height: 125,
                                width: 180,
                                child:
                                    bannerPath.isNotEmpty
                                        ? Image.file(
                                          File(bannerPath),
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (_, __, ___) => Image.asset(
                                                'assets/images/Null_ticket.png',
                                              ),
                                        )
                                        : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/uploadicon.svg',
                                              color: AppColors.secondary,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Upload banner',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'JPEG, PNG less than 5MB',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 10),
                        Text(
                          'Upload your banner\n      here (2:1)',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // GestureDetector(
                //   onTap:
                //       () => Get.toNamed(
                //         "/store_template",
                //         arguments: {
                //           'firstName': firstName,
                //           'lastName': lastName,
                //           'category': arguments['category'],
                //           'savedIndexes':
                //               storeDetailsFormController.selectedIndexes
                //                   .toList(),
                //         },
                //       ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.star,
                //         size: 30,
                //         color: AppColors.primaryGradinatMixColor,
                //       ),
                //       Text(
                //         " If you don't have Profile & banner\n Use Farmitra Templates",
                //         style: GoogleFonts.montserrat(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: AppColors.primaryGradinatMixColor,
                //           decoration: TextDecoration.underline,
                //           decorationColor: AppColors.primaryGradinatMixColor,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 10),
                // const SizedBox(height: 10),
                storeCategoryController.previousPageGridTitle.trim() == 'Rental'
                    ? Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropdown<String>(
                            hint: 'Choose Rental Services',
                            items: storeDetailsFormController.rentalItemList,
                            selectedItem:
                                storeDetailsFormController
                                        .selectedRentalItem
                                        .value
                                        .isEmpty
                                    ? null
                                    : storeDetailsFormController
                                        .selectedRentalItem
                                        .value,
                            onChanged: (value) {
                              storeDetailsFormController
                                  .updateSelectedRentalItem(value ?? '');
                            },
                            itemBuilder: (item) => item,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            hintText: 'Other',
                            keyboardType: TextInputType.text,
                            controller: storeDetailsFormController.other,
                            validator: (value) {
                              if (storeDetailsFormController
                                          .selectedRentalItem
                                          .value ==
                                      'Others' &&
                                  (value == null || value.isEmpty)) {
                                return 'Please specify other rental item';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink(),
                SizedBox(height: 10),
                // CustomTextFormField(
                //   hintText: 'Expert Profile Name',
                //   keyboardType: TextInputType.text,
                //   controller: storeDetailsFormController.expertName,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please Enter Name';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Expert Name',
                  keyboardType: TextInputType.text,
                  controller: storeDetailsFormController.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'WhatsApp number',
                  keyboardType: TextInputType.number,
                  controller: storeDetailsFormController.whatsAppNumber,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null; // Optional field
                    }
                    if (value.length < 10) {
                      return 'Please enter a 10-digit WhatsApp number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Location',
                  keyboardType: TextInputType.text,
                  controller: storeLocationController.combinedController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Location';
                    }
                    return null;
                  },
                  suffixIcon: Icons.location_on_sharp,
                  onSuffixIconTap: () => Get.toNamed('/store_location'),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Enter pin code ',
                  keyboardType: TextInputType.number,
                  controller: storeLocationController.pincode,
                  // retailerStoreDetailsFormController.pincode,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please Enter Pin Code ";
                    if (value.length < 6) return 'Enter 6 Digit Valid Pin Code';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                CustomTextFormField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: storeDetailsFormController.email,
                  validator:
                      (value) =>
                          storeDetailsFormController.validateEmail(value),
                ),
                // const SizedBox(height: 10),
                // Obx(
                //   () => Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Radio<String>(
                //         activeColor: AppColors.primaryGradinatMixColor,
                //         value: 'Male',
                //         groupValue:
                //             storeDetailsFormController.selectedGender.value,
                //         onChanged:
                //             (value) =>
                //                 storeDetailsFormController.changeGender(value!),
                //       ),
                //       const Text('Male'),
                //       const SizedBox(width: 20),
                //       Radio<String>(
                //         activeColor: AppColors.primaryGradinatMixColor,
                //         value: 'Female',
                //         groupValue:
                //             storeDetailsFormController.selectedGender.value,
                //         onChanged:
                //             (value) =>
                //                 storeDetailsFormController.changeGender(value!),
                //       ),
                //       const Text('Female'),
                //       const SizedBox(width: 20),
                //       Radio<String>(
                //         activeColor: AppColors.primaryGradinatMixColor,
                //         value: 'Other',
                //         groupValue:
                //             storeDetailsFormController.selectedGender.value,
                //         onChanged:
                //             (value) =>
                //                 storeDetailsFormController.changeGender(value!),
                //       ),
                //       const Text('Other'),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'About Expert',
                  borderRadius: 10,
                  keyboardType: TextInputType.text,
                  controller: storeDetailsFormController.about,
                  maxLines: 3,
                  validator: (value) => null, // Optional field
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Language Spoken'),
                    const Icon(Icons.arrow_forward_ios_outlined, size: 15),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: storeDetailsFormController.languages.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        bool isSelected = storeDetailsFormController.isSelected(
                          index,
                        );
                        return GestureDetector(
                          onTap: () {
                            print('ListView.builder: Tapped index $index');
                            storeDetailsFormController.toggleSelection(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.primaryGradinatMixColor
                                      : Colors.transparent,
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.transparent
                                        : AppColors.border,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              storeDetailsFormController.languages[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomGradientButton(
                  text: 'Next',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Future(() async {
                        // Show loader dialog
                        Get.dialog(
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                          barrierDismissible: false,
                        );

                        try {
                          await storeDetailsFormController
                              .submitRetailerStoreDetails();
                        } finally {
                          // Ensure loader closes here
                          if (Get.isDialogOpen ?? false) Get.back();
                        }
                      });
                    } else {
                      Get.snackbar(
                        'Notice',
                        "All fields are required & mandatory ",
                        backgroundColor: AppColors.appBarColor,
                        colorText: AppColors.white,
                      );
                    }
                  },
                ),

                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}
