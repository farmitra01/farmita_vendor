import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/home_bottom_bar_controller.dart';
import 'package:farmitra/app/modules/kyc_documents/views/owners_details.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/kyc_documents_controller.dart';

class KycDocumentsView extends GetView<KycDocumentsController> {
  KycDocumentsView({super.key});

  final KycDocumentsController kycDocumentsController = Get.put(
    KycDocumentsController(),
  );
  final HomeBottomBarController homeBottomBarController =
      Get.find<HomeBottomBarController>();
  final box = GetStorage();
  var previousPageGridTitle = Get.arguments;
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (box.read('user_role') ?? '') == 'Expert'
                    ? 'A. Profession Details'
                    : 'A. Business Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please Select The Experties of Expert',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // SizedBox(height: 10),
                    // Obx(
                    //   () => CustomDropdown<String>(
                    //     hint: 'Area of Experties',
                    //     items:
                    //         kycDocumentsController
                    //             .storeChannelList, // Keep it as List<String>
                    //     selectedItem:
                    //         kycDocumentsController.selectedItem.value.isEmpty
                    //             ? null
                    //             : kycDocumentsController.selectedItem.value,
                    //     onChanged: (value) {
                    //       kycDocumentsController.updatedSelectedValue(
                    //         value ?? '',
                    //       );
                    //     },
                    //     itemBuilder: (item) => item, // Correct item mapping
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    // CustomTextFormField(
                    //   hintText: 'Other Experties',
                    //   keyboardType: TextInputType.text,
                    //   controller: kycDocumentsController.specialization,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please Enter Other Experties';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 10),

                    // Text(
                    //   'Highest Qualification',
                    //   style: GoogleFonts.montserrat(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.textPrimary,
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Obx(
                      () => CustomDropdown<String>(
                        hint: 'Choose Highest Qualification',
                        items:
                            kycDocumentsController
                                .qualification, // Keep it as List<String>
                        selectedItem:
                            kycDocumentsController
                                    .selectedItemQualification
                                    .value
                                    .isEmpty
                                ? null
                                : kycDocumentsController
                                    .selectedItemQualification
                                    .value,
                        onChanged: (value) {
                          kycDocumentsController
                              .updatedSelectedValueQualification(value ?? '');
                        },
                        itemBuilder: (item) => item, // Correct item mapping
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Specialization',
                      keyboardType: TextInputType.text,
                      controller: kycDocumentsController.specialization,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Expert Name';
                        }
                        return null;
                      },
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextFormField(
                    //         borderRadius: 10,
                    //         hintText: 'Enter Area of Experties',
                    //         keyboardType: TextInputType.text,
                    //         controller: kycDocumentsController.experArea,
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'Please Enter Email';
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(width: 5),
                    //     SizedBox(
                    //       height: 55,
                    //       width: 100,
                    //       child: CustomGradientButton(
                    //         borderRadius: 10,
                    //         text: 'Add',
                    //         onPressed: () {},
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed('/select_document');
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(25),
                    //       border: Border.all(color: AppColors.border),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text('     Select a document'),
                    //         Icon(Icons.arrow_right_sharp, size: 30),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Upload your Certificate here ',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGradinatMixColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        _uploadCertificateDialog(); // Show image source dialog on tap
                      },
                      child: Center(
                        child: DottedBorder(
                          color: AppColors.border,
                          dashPattern: [6, 3],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () =>
                                      kycDocumentsController
                                                  .selectedImage
                                                  .value !=
                                              null
                                          ? Image.file(
                                            kycDocumentsController
                                                .selectedImage
                                                .value!,
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                          : SvgPicture.asset(
                                            'assets/icons/uploadicon.svg',
                                          ),
                                ),
                                Text(
                                  'Upload Certificate',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'JPEG, PNG less than 5MB',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
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
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.check, size: 20),
                                    Text('  Registration number'),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.check, size: 20),
                                    Text('  Certificate number'),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.check, size: 20),
                                    Text('  Experties Area'),
                                  ],
                                ),
                                SizedBox(height: 5),
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
                                  content: Image.asset(
                                    'assets/images/certificate Sample Image.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                              child: Container(
                                height: 120,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.border),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/certificate Sample Image.jpg',
                                    ),
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

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Expanded(
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               _showImagePickerDialog(
                    //                 'inside',
                    //               ); // Choose for inside image
                    //             },
                    //             child: Column(
                    //               children: [
                    //                 Obx(
                    //                   () => DottedBorder(
                    //                     strokeWidth: 1,
                    //                     borderType: BorderType.RRect,
                    //                     dashPattern: [6, 3],
                    //                     color: AppColors.border,
                    //                     radius: Radius.circular(15),
                    //                     child: Container(
                    //                       padding: EdgeInsets.symmetric(
                    //                         horizontal: 15,
                    //                         vertical: 10,
                    //                       ),
                    //                       child: Center(
                    //                         child: Column(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.center,
                    //                           children: [
                    //                             kycDocumentsController
                    //                                         .insideImage
                    //                                         .value !=
                    //                                     null
                    //                                 ? Image.file(
                    //                                   kycDocumentsController
                    //                                       .insideImage
                    //                                       .value!,
                    //                                   height: 100,
                    //                                   width: 100,
                    //                                   fit: BoxFit.cover,
                    //                                 )
                    //                                 : SvgPicture.asset(
                    //                                   'assets/icons/uploadicon.svg',
                    //                                 ),
                    //                             SizedBox(height: 5),
                    //                             Text(
                    //                               'Upload Inside Image',
                    //                               style: GoogleFonts.montserrat(
                    //                                 fontSize: 10,
                    //                                 fontWeight: FontWeight.w500,
                    //                               ),
                    //                             ),
                    //                             SizedBox(height: 5),
                    //                             Text(
                    //                               'JPEG, PNG less than\n15MB',
                    //                               style: GoogleFonts.montserrat(
                    //                                 fontSize: 10,
                    //                                 fontWeight: FontWeight.w400,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 SizedBox(height: 10),
                    //                 Text(
                    //                   'Inside',
                    //                   style: GoogleFonts.montserrat(
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: AppColors.textSecondary,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 15),
                    //         Expanded(
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               _showImagePickerDialog(
                    //                 'outside',
                    //               ); // Choose for outside image
                    //             },
                    //             child: Column(
                    //               children: [
                    //                 Obx(
                    //                   () => DottedBorder(
                    //                     strokeWidth: 1,
                    //                     borderType: BorderType.RRect,
                    //                     dashPattern: [6, 3],
                    //                     color: AppColors.border,
                    //                     radius: Radius.circular(15),
                    //                     child: Container(
                    //                       padding: EdgeInsets.symmetric(
                    //                         horizontal: 15,
                    //                         vertical: 10,
                    //                       ),
                    //                       child: Center(
                    //                         child: Column(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.center,
                    //                           children: [
                    //                             kycDocumentsController
                    //                                         .outsideImage
                    //                                         .value !=
                    //                                     null
                    //                                 ? Image.file(
                    //                                   kycDocumentsController
                    //                                       .outsideImage
                    //                                       .value!,
                    //                                   height: 100,
                    //                                   width: 100,
                    //                                   fit: BoxFit.cover,
                    //                                 )
                    //                                 : SvgPicture.asset(
                    //                                   'assets/icons/uploadicon.svg',
                    //                                 ),
                    //                             SizedBox(height: 5),
                    //                             Text(
                    //                               'Upload Outside Image',
                    //                               style: GoogleFonts.montserrat(
                    //                                 fontSize: 10,
                    //                                 fontWeight: FontWeight.w500,
                    //                               ),
                    //                             ),
                    //                             SizedBox(height: 5),
                    //                             Text(
                    //                               'JPEG, PNG less than\n15MB',
                    //                               style: GoogleFonts.montserrat(
                    //                                 fontSize: 10,
                    //                                 fontWeight: FontWeight.w400,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Text(
                    //                   'Outside',
                    //                   style: GoogleFonts.montserrat(
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: AppColors.textSecondary,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(thickness: 1, color: AppColors.border),
                        ),
                        Text(
                          '&',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: AppColors.border),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "B. Expert KYC",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please upload at least one document.',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(OwnersDetails());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('     Select a document'),
                            Icon(Icons.arrow_right_sharp, size: 30),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.check, size: 20),
                                    Text('  Full Name'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.check, size: 20),
                                    Text('  Photo'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.check, size: 20),
                                    Text('  ID Number'),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                  title: '',
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
                                  content: Image.asset(
                                    'assets/images/Aadhar.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                              child: Container(
                                height: 120,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.border),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/Aadhar.jpg',
                                    ),
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

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           _showImagePickerDialog(
                    //             'ownerWithFrontShop',
                    //           ); // Choose for outside image
                    //         },
                    //         child: Column(
                    //           children: [
                    //             Obx(
                    //               () => DottedBorder(
                    //                 strokeWidth: 1,
                    //                 borderType: BorderType.RRect,
                    //                 dashPattern: [6, 3],
                    //                 color: AppColors.border,
                    //                 radius: Radius.circular(15),
                    //                 child: Container(
                    //                   padding: EdgeInsets.symmetric(
                    //                     horizontal: 15,
                    //                     vertical: 10,
                    //                   ),
                    //                   child: Center(
                    //                     child: Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         kycDocumentsController
                    //                                     .ownerWithFrontShop
                    //                                     .value !=
                    //                                 null
                    //                             ? Image.file(
                    //                               kycDocumentsController
                    //                                   .ownerWithFrontShop
                    //                                   .value!,
                    //                               height: 100,
                    //                               width: 100,
                    //                               fit: BoxFit.cover,
                    //                             )
                    //                             : SvgPicture.asset(
                    //                               'assets/icons/uploadicon.svg',
                    //                               fit: BoxFit.fill,
                    //                             ),
                    //                         SizedBox(height: 5),
                    //                         Text(
                    //                           'Upload Inside Image',
                    //                           style: GoogleFonts.montserrat(
                    //                             fontSize: 10,
                    //                             fontWeight: FontWeight.w500,
                    //                           ),
                    //                         ),
                    //                         SizedBox(height: 5),
                    //                         Text(
                    //                           'JPEG, PNG less than\n               10MB',
                    //                           style: GoogleFonts.montserrat(
                    //                             fontSize: 10,
                    //                             fontWeight: FontWeight.w400,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(height: 10),
                    //             Text(
                    //               'Front of the\nStore or shop',
                    //               style: GoogleFonts.montserrat(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: AppColors.textSecondary,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15),
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           _showImagePickerDialog('ownerWithInsideShop');
                    //         },
                    //         child: Column(
                    //           children: [
                    //             Obx(
                    //               () => DottedBorder(
                    //                 strokeWidth: 1,
                    //                 borderType: BorderType.RRect,
                    //                 dashPattern: [6, 3],
                    //                 color: AppColors.border,
                    //                 radius: Radius.circular(15),
                    //                 child: Container(
                    //                   padding: EdgeInsets.symmetric(
                    //                     horizontal: 15,
                    //                     vertical: 10,
                    //                   ),
                    //                   child: Center(
                    //                     child: Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         kycDocumentsController
                    //                                     .ownerWithInsideShop
                    //                                     .value !=
                    //                                 null
                    //                             ? Image.file(
                    //                               kycDocumentsController
                    //                                   .ownerWithInsideShop
                    //                                   .value!,
                    //                               height: 100,
                    //                               width: 100,
                    //                               fit: BoxFit.cover,
                    //                             )
                    //                             : SvgPicture.asset(
                    //                               'assets/icons/uploadicon.svg',
                    //                               fit: BoxFit.fill,
                    //                             ),
                    //                         const SizedBox(height: 5),
                    //                         Text(
                    //                           'Upload Outside Image',
                    //                           style: GoogleFonts.montserrat(
                    //                             fontSize: 10,
                    //                             fontWeight: FontWeight.w500,
                    //                           ),
                    //                         ),
                    //                         SizedBox(height: 5),
                    //                         Text(
                    //                           'JPEG, PNG less than\n               10MB',
                    //                           style: GoogleFonts.montserrat(
                    //                             fontSize: 10,
                    //                             fontWeight: FontWeight.w400,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(height: 10),
                    //             Text(
                    //               'Inside of the\nStore or shop',
                    //               style: GoogleFonts.montserrat(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Color(0xff636363),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryFirstGradiant,
                      AppColors.primarySecondGradiant,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Get.toNamed('/bank-details');
                  },
                  child: Text(
                    'Save & Next',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/bank-details', arguments: previousPageGridTitle);
              },
              child: Text(
                'Skip for now!',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

void _showImagePickerDialog(String type) {
  final KycDocumentsController kycDocumentsController = Get.put(
    KycDocumentsController(),
  );

  showDialog(
    context: Get.context!, // Since you're using GetX
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
        // content: Column(
        //   mainAxisSize: MainAxisSize.min, // To avoid the dialog being too large
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // If you need to add additional content here
        //   ],
        // ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close dialog
                  kycDocumentsController.captureImage();
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
                  (); // Close dialog
                  kycDocumentsController.uploadFromGallery();
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

void _uploadCertificateDialog() {
  final KycDocumentsController kycDocumentsController = Get.put(
    KycDocumentsController(),
  );
  showDialog(
    context: Get.context!, // Since you're using GetX
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
        content: Column(
          mainAxisSize: MainAxisSize.min, // To avoid the dialog being too large
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If you need to add additional content here
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close dialog
                  kycDocumentsController.pickImage(ImageSource.camera);
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
                  (); // Close dialog
                  kycDocumentsController.pickImage(ImageSource.gallery);
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
