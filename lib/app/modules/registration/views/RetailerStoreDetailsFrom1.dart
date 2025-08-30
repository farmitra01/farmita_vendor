import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
// import 'package:farmitra/app/data/models/store_category_model/store_template_model.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/retailer_store_details_form_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RetailerStoreDetailsFrom1 extends StatelessWidget {
  const RetailerStoreDetailsFrom1({super.key});

  static final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final StoreLocationController storeLocationController = Get.put(
      StoreLocationController(),
    );
    final RetailerStoreDetailsFormController
    retailerStoreDetailsFormController = Get.put(
      RetailerStoreDetailsFormController(),
    );
    final StoreCategoryController storeCategoryController = Get.put(
      StoreCategoryController(),
    );

    final String? firstName =
        retailerStoreDetailsFormController.arguments['firstName'] as String? ??
        'Farmitra';
    final String lastName =
        retailerStoreDetailsFormController.arguments['lastName'] as String? ??
        storeCategoryController.previousPageGridTitle ??
        'Expert';

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        onHelpTap: () => Get.toNamed('/help-center'),
        onTranslateTap: () => Get.toNamed('/add'),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Business Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo Upload
                  Column(
                    children: [
                      Obx(() {
                        final logoPath =
                            retailerStoreDetailsFormController
                                .selectedLogoPath
                                .value;
                        return GestureDetector(
                          onTap: () {
                            retailerStoreDetailsFormController.pickImage(
                              'logo',
                            );
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

                  /// Banner Upload
                  Column(
                    children: [
                      Obx(() {
                        final bannerPath =
                            retailerStoreDetailsFormController
                                .selectedBannerPath
                                .value;

                        return GestureDetector(
                          onTap: () async {
                            final source =
                                await retailerStoreDetailsFormController
                                    .selectImageSourceDialog();

                            if (source == null) return;

                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                              source: source,
                              imageQuality: 85,
                            );
                            if (pickedFile != null) {
                              retailerStoreDetailsFormController
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

              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Business Name ',
                keyboardType: TextInputType.text,
                controller: retailerStoreDetailsFormController.businessName,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please Enter Business Name'
                            : null,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: "Owner's Name",
                keyboardType: TextInputType.text,
                controller: retailerStoreDetailsFormController.ownerName,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Please Enter Owner's Name"
                            : null,
              ),
              // const SizedBox(height: 10),
              // Obx(
              //   () => CustomDropdown<String>(
              //     hint: 'Store Channel',
              //     items: retailerStoreDetailsFormController.storeChannelList,
              //     selectedItem:
              //         retailerStoreDetailsFormController
              //                 .selectedItem
              //                 .value
              //                 .isEmpty
              //             ? null
              //             : retailerStoreDetailsFormController
              //                 .selectedItem
              //                 .value,
              //     onChanged:
              //         (value) => retailerStoreDetailsFormController
              //             .updatedSelectedValue(value ?? ''),

              //     itemBuilder: (item) => item,
              //   ),
              // ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: ' Whats app number',
                keyboardType: TextInputType.number,
                controller: retailerStoreDetailsFormController.whatsAppNumber,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please Enter What's App Number";
                  if (value.length < 10) return 'Enter 10 Digit Valid Number';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: retailerStoreDetailsFormController.email,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please Enter Email';
                  if (!RegExp(
                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                  ).hasMatch(value))
                    return 'Please Enter Valid Email';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: ' Location',
                maxLines: storeLocationController.pincode == false ? 1 : 3,
                keyboardType: TextInputType.text,
                controller: storeLocationController.combinedController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Please Enter Location"
                            : null,
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
            ],
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
                  if (formkey.currentState!.validate()) {
                    retailerStoreDetailsFormController
                        .submitRetailerStoreDetails();

                    // print('Retailer Next Button Tapped');
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
            ),
            // GestureDetector(
            //   child: Text(
            //     "You Can’t Skip this step",
            //     style: GoogleFonts.montserrat(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500,
            //       color: AppColors.primaryGradinatMixColor,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
