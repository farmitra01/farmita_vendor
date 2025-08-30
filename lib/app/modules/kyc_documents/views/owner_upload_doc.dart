import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/controllers/owner_upload_doc_controller.dart';
import 'package:farmitra/app/modules/kyc_documents/views/owners_details.dart';
import 'package:farmitra/app/modules/registration/controllers/store_details_form_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerUploadDoc extends StatelessWidget {
  OwnerUploadDoc({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final OwnerUploadDocController ownerUploadDocController = Get.put(
    OwnerUploadDocController(),
  );
  final StoreDetailsFormController storeDetailsFormController = Get.put(
    StoreDetailsFormController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 2/2 Upload Document:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Documents required for complete KYC',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
              ();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryGradinatMixColor,
                child: Icon(Icons.close, color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(thickness: 1, color: AppColors.border),
                SizedBox(height: 15),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Certificate Must show:',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkBlue,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.check, size: 20),
                                Text(
                                  '  Full name',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.check, size: 20),
                                Text(
                                  '  Photo',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.check, size: 20),
                                Text(
                                  '  ID number',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: 'Sample',
                              titlePadding: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                                bottom: 0,
                              ),
                              titleStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                              content: Center(
                                child: buildDocumentImage(
                                  ownerUploadDocController,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.border),
                              image: DecorationImage(
                                image: () {
                                  switch (ownerUploadDocController
                                      .documentName) {
                                    case 'Aadhar Card':
                                      return const AssetImage(
                                        'assets/images/Aadhar.jpg',
                                      );
                                    case 'PAN Card':
                                      return const AssetImage(
                                        'assets/images/pan-card.png',
                                      );
                                    case 'Voter ID':
                                      return const AssetImage(
                                        'assets/images/voter id.webp',
                                      );
                                    case 'Passport':
                                      return const AssetImage(
                                        'assets/images/passport.jpg',
                                      );
                                    case 'Driving License':
                                      return const AssetImage(
                                        'assets/images/DrivingLicense.jpg',
                                      );
                                    default:
                                      return const AssetImage(
                                        'assets/images/default.png',
                                      ); // 👈 fallback
                                  }
                                }(),
                                fit: BoxFit.fill,
                                opacity: 0.2,
                              ),
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.visibility),
                                Text(
                                  'View Sample',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Fill the ${ownerUploadDocController.documentName} Details Below',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Enter Full Name',
                  keyboardType: TextInputType.text,
                  controller: ownerUploadDocController.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Full Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Enter Document ID/No.',
                  keyboardType: TextInputType.text,
                  controller: ownerUploadDocController.documentIdNo,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Document ID/No.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Upload your document here (2:1)',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                ownerUploadDocController.documentName != 'Aadhar Card'
                    ? InkWell(
                      onTap: () {
                        ownerUploadDocController.pickImage('Front Side');
                      },

                      child: DottedBorder(
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        dashPattern: [6, 3],
                        color: AppColors.border,
                        radius: Radius.circular(15),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Obx(
                                  () =>
                                      ownerUploadDocController
                                              .inside
                                              .value
                                              .isNotEmpty
                                          ? Image.file(
                                            File(
                                              ownerUploadDocController
                                                  .inside
                                                  .value,
                                            ),
                                            height: 100,
                                            width: 200,
                                            fit: BoxFit.fill,
                                          )
                                          : SvgPicture.asset(
                                            'assets/icons/uploadicon.svg',
                                          ),
                                ),

                                SizedBox(height: 5),
                                Text(
                                  'Tap & Upload  Image',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'JPEG, PNG less than\n               15MB',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ownerUploadDocController.pickImage(
                                  'Front Side',
                                );
                              },
                              child: Obx(() {
                                return DottedBorder(
                                  dashPattern: [2.5, 5],
                                  borderType: BorderType.RRect,
                                  color: AppColors.border,
                                  radius: Radius.circular(10),
                                  child: Container(
                                    height: 120,
                                    width: 135,
                                    child:
                                        ownerUploadDocController
                                                .inside
                                                .value
                                                .isEmpty
                                            ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,

                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svgs/uploadicon.svg',
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Tap & Upload Front Image',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'JPEG,PNG,less then 10 MB',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            )
                                            : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(
                                                  ownerUploadDocController
                                                      .inside
                                                      .value,
                                                ),
                                              ),
                                            ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Front Side',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  ownerUploadDocController.pickImage(
                                    'Back Side',
                                  );
                                },
                                child: DottedBorder(
                                  dashPattern: [2.5, 5],
                                  borderType: BorderType.RRect,
                                  color: AppColors.border,
                                  radius: Radius.circular(10),
                                  child: Container(
                                    height: 120,
                                    width: 135,
                                    child:
                                        ownerUploadDocController
                                                .outside
                                                .value
                                                .isEmpty
                                            ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svgs/uploadicon.svg',
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Tap & Upload Back Image',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'JPEG,PNG,less then 10 MB',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            )
                                            : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(
                                                  ownerUploadDocController
                                                      .outside
                                                      .value,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: 10),
                            Text(
                              'Back Side',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: ownerUploadDocController.isChecked.value,
                      activeColor: AppColors.primaryGradinatMixColor,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        ownerUploadDocController.toggleCheckBox(value);
                      },
                    ),
                  ),
                  Text(
                    'I confirm my submission for this document.',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomGradientButton(
                text: 'Submit',
                onPressed: () async {
                  if (formkey.currentState!.validate() &&
                      ownerUploadDocController.isChecked.value == true) {
                    // Call API
                    bool success =
                        await ownerUploadDocController.submitOwnerDocument();

                    if (success) {
                      // Navigate if successful
                      // Get.toNamed('/business_kyc');.
                      Get.to(OwnersDetails());

                      // Get.back();
                    }
                  } else {
                    Get.snackbar(
                      'Notice',
                      'Text field and checkbox are required field',
                      backgroundColor: AppColors.appBarColor,
                      colorText: AppColors.primaryGradinatMixColor,
                    );
                  }
                },
              ),

              SizedBox(height: 10),
              Text(
                'Contact for help!',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDocumentImage(OwnerUploadDocController ownerUploadDocController) {
  switch (ownerUploadDocController.documentName) {
    case 'Aadhar Card':
      return Image(
        image: AssetImage('assets/images/Aadhar.jpg'),
        height: 150,
        width: 200,
        fit: BoxFit.fill,
      );
    case 'PAN Card':
      return Image(
        image: AssetImage('assets/images/pan-card.png'),
        height: 150,
        width: 200,
        fit: BoxFit.fill,
      );
    case 'Voter ID':
      return Image(
        image: AssetImage('assets/images/voter id.webp'),
        height: 150,
        width: 200,
        fit: BoxFit.fill,
      );
    case 'Passport':
      return Image(
        image: AssetImage('assets/images/passport.jpg'),
        height: 150,
        width: 200,
        fit: BoxFit.fill,
      );
    case 'Driving License':
      return Image(
        image: AssetImage('assets/images/DrivingLicense.jpg'),
        height: 150,
        width: 200,
        fit: BoxFit.fill,
      );
    default:
      return const SizedBox(); // empty if no match
  }
}
