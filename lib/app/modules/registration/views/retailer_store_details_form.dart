// import 'dart:io';
// import 'dart:ui' as BorderType;

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/models/store_category_model/store_template_model.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/retailer_store_details_form_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_details_form_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_template_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class RetailerStoreDetailsFrom extends StatelessWidget {
  RetailerStoreDetailsFrom({super.key});
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final StoreLocationController storeLocationController = Get.put(
    StoreLocationController(),
  );
  final StoreDetailsFormController storeDetailsFormController = Get.put(
    StoreDetailsFormController(),
  );
  final RetailerStoreDetailsFormController retailerStoreDetailsFormController =
      Get.put(RetailerStoreDetailsFormController());

  final StoreTemplateController storeTemplateController = Get.put(
    StoreTemplateController(),
  );
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  var previousPageGridTitle = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print('previous page content = ${previousPageGridTitle}');

    final StoreTemplateModel? selectedTemplate =
        Get.arguments is StoreTemplateModel
            ? Get.arguments as StoreTemplateModel
            : null;

    // print('Received store template data: $selectedTemplate');

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        onHelpTap: () {
          Get.toNamed('/help-center');
        },
        onTranslateTap: () {
          Get.toNamed('/add');
        },
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Mart Details',
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
                          return GestureDetector(
                            onTap:
                                () => retailerStoreDetailsFormController
                                    .pickImage('logo'),
                            child: DottedBorder(
                              color: AppColors.border,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              borderType: BorderType.Circle,
                              radius: const Radius.circular(100),
                              child: Container(
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: selectedTemplate?.backgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    retailerStoreDetailsFormController
                                            .selectedLogoPath
                                            .value
                                            .isEmpty
                                        ? selectedTemplate != null
                                            ? Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Farmitra',
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            selectedTemplate!
                                                                .spanTextColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          storeCategoryController
                                                                      .previousPageGridTitle ==
                                                                  'Expert'
                                                              ? 'Expert'
                                                              : storeCategoryController
                                                                      .previousPageGridTitle ==
                                                                  'Rental'
                                                              ? 'Rental'
                                                              : storeCategoryController
                                                                      .previousPageGridTitle ==
                                                                  'Drone'
                                                              ? 'Drone'
                                                              : 'Mart',

                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors
                                                                .primaryGradinatMixColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/uploadicon.svg',
                                                  color:
                                                      AppColors.textSecondary,
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
                                                  'JPEG, PNG less\n    than 3MB',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              ],
                                            )
                                        : ClipOval(
                                          child: Image.file(
                                            File(
                                              retailerStoreDetailsFormController
                                                  .selectedLogoPath
                                                  .value,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        Text(
                          'Upload your logo\n       here (1:1)',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Obx(() {
                          return GestureDetector(
                            onTap:
                                () => retailerStoreDetailsFormController
                                    .pickImage('banner'),
                            child: DottedBorder(
                              color: AppColors.border,
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              borderType: BorderType.RRect, // Correct enum
                              radius: const Radius.circular(
                                12,
                              ), // Works with RRect only
                              child: Container(
                                height: 125,
                                width: 180,
                                child:
                                    retailerStoreDetailsFormController
                                            .selectedBannerPath
                                            .value
                                            .isEmpty
                                        ? selectedTemplate != null
                                            ? Stack(
                                              children: [
                                                Image.asset(
                                                  selectedTemplate!.bannerImage,
                                                  fit: BoxFit.cover,
                                                  width: 180,
                                                  height: 125,
                                                ),
                                                Positioned(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Farmitra',
                                                              style: GoogleFonts.montserrat(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    selectedTemplate!
                                                                        .spanTextColor,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  storeCategoryController
                                                                              .previousPageGridTitle ==
                                                                          'Expert'
                                                                      ? 'Expert'
                                                                      : storeCategoryController
                                                                              .previousPageGridTitle ==
                                                                          'Rental'
                                                                      ? 'Rental'
                                                                      : storeCategoryController
                                                                              .previousPageGridTitle ==
                                                                          'Drone'
                                                                      ? 'Drone'
                                                                      : 'Mart',
                                                              style: GoogleFonts.montserrat(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    AppColors
                                                                        .primaryGradinatMixColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
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
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ),
                                                Text(
                                                  'JPEG, PNG less than 5MB',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              ],
                                            )
                                        : Image.file(
                                          File(
                                            retailerStoreDetailsFormController
                                                .selectedBannerPath
                                                .value,
                                          ),
                                          fit: BoxFit.cover,
                                          width: 180,
                                          height: 125,
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/store_template");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 30,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                      Text(
                        " If you don't have logo & banner\n Use First Find Templates",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGradinatMixColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Store Name ',
                  keyboardType: TextInputType.text,
                  controller: retailerStoreDetailsFormController.businessName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Store Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Store Owner ',
                  keyboardType: TextInputType.text,
                  controller: retailerStoreDetailsFormController.businessName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Store Name';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 10),
                // Obx(
                //   () => CustomDropdown<String>(
                //     hint: 'Store Channel',
                //     items:
                //         retailerStoreDetailsFormController
                //             .storeChannelList, // Keep it as List<String>
                //     selectedItem:
                //         retailerStoreDetailsFormController
                //                 .selectedItem
                //                 .value
                //                 .isEmpty
                //             ? null
                //             : retailerStoreDetailsFormController
                //                 .selectedItem
                //                 .value,
                //     onChanged: (value) {
                //       retailerStoreDetailsFormController.updatedSelectedValue(
                //         value ?? '',
                //       );
                //     },
                //     itemBuilder: (item) => item, // Correct item mapping
                //   ),
                // ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Store Whats app number',
                  keyboardType: TextInputType.number,
                  controller: retailerStoreDetailsFormController.whatsAppNumber,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter What's App Number";
                    } else if (value.length < 10) {
                      return 'Enter 10 Digit Valid Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Store Location',
                  keyboardType: TextInputType.text,
                  controller: storeLocationController.combinedController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Store Location";
                    }
                    return null;
                  },
                  suffixIcon: Icons.location_on_sharp,
                  onSuffixIconTap: () {
                    Get.toNamed('/store_location');
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: retailerStoreDetailsFormController.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!RegExp(
                      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                    ).hasMatch(value)) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: CustomGradientButton(
                text: 'Next',
                onPressed: () {
                  if (formkey.currentState!.validate() &&
                      retailerStoreDetailsFormController.validateForm()) {
                    // If both form fields and image validation pass, close the form or proceed
                    previousPageGridTitle == 'Expert'
                        ? Get.toNamed(
                          '/kyc-documents',
                          arguments: previousPageGridTitle,
                        )
                        : Get.to(() => RentalKyc());
                  } else {
                    // If either form or image validation fails, show error
                    Get.snackbar(
                      'Notice',
                      "All fileds are required & mandatory ",
                      backgroundColor: AppColors.appBarColor,
                      colorText: AppColors.white,
                    );
                  }
                },
              ),
            ),
            GestureDetector(
              // onTap: () {
              //   previousPageGridTitle == 'Expert'
              //       ? Get.toNamed(
              //         '/kyc-documents',
              //         arguments: previousPageGridTitle,
              //       )
              //       : Get.to(() => RentalKyc());
              // },
              child: Text(
                 "You Can’t Skip this step",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
