import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_image_picker_widget.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/owner_profile_controller.dart';

class OwnerProfileView extends GetView<OwnerProfileController> {
  OwnerProfileView({super.key});
  final OwnerProfileController ownerProfileController = Get.put(
    OwnerProfileController(),
  );
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(
        title: 'My Profile',
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(Icons.chat_outlined, color: AppColors.white, size: 18),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(Icons.email_outlined, color: AppColors.white, size: 18),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffC7C7C7),
                      Color(0xffFFFFFF),
                      Color(0xffC7C7C7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.lightGrey,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    35,
                                  ),
                                  child: Image.network(
                                    'https://api.farmitra.in/storage/${box.read('user_details')['logo']}',
                                    height: 75,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.bottomLeft,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                                radius: 35,
                              ),
                              Positioned(
                                bottom: 8,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.background,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.green,
                                    radius: 5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/svgs/farmitra.svg',
                            width: 80,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Amit Kumar Singh',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      GradientText(
                        text: 'Store Owner',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primarySecondGradiant,
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.call_outlined,
                                    color: AppColors.textSecondary,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '+91 88022 04443',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alternate_email,
                                    color: AppColors.textSecondary,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'teststore@firstfind.com',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: AppColors.textSecondary,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Noida, Uttar Pradesh',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color:Colors.green),
                                  color: AppColors.background,
                                ),
                                child: Icon(Icons.qr_code_outlined, size: 25),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Tap to scan',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.background,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'A. User details:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        color: AppColors.border,
                        dashPattern: [2, 3],
                        radius: Radius.circular(15),
                        child: Container(
                          // height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Profile Picture",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "JPEG, PNG less than 3MB",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GradientText(
                                      text: 'Upload',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryFirstGradiant,
                                          AppColors.primarySecondGradiant,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(color: AppColors.border),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: AppColors.background,
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "amitkumarsingh.jpeg",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.lightskyBlue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Delete",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.check_circle,
                                      color: Color(0xff4C83EA),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // CustomTextFormField(
                      //   hintText: 'Full Name',
                      //   keyboardType: TextInputType.text,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.name,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),

                      // CustomTextFormField(
                      //   hintText: '+91',
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.number,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),
                      // CustomGradientButton(text: 'Get OTP', onPressed: () {}),
                      // SizedBox(height: 10),
                      // CustomTextFormField(
                      //   hintText: 'Alternate number',
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.altNumber,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),
                      // CustomTextFormField(
                      //   hintText: 'Email',
                      //   keyboardType: TextInputType.emailAddress,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.email,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),
                      // CustomTextFormField(
                      //   hintText: 'Location',
                      //   keyboardType: TextInputType.text,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.location,
                      //   validator: (p0) {},
                      //   prefixIcon: Icon(
                      //     Icons.location_on,
                      //     color: Color(0x636363),
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // CustomTextFormField(
                      //   hintText: 'Complete Address',
                      //   keyboardType: TextInputType.text,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.address,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),
                      // CustomTextFormField(
                      //   hintText: 'Floor',
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.floor,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),
                      // CustomTextFormField(
                      //   hintText: 'Pin Code',
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: [],
                      //   controller: ownerProfileController.pincode,
                      //   validator: (p0) {},
                      // ),
                      // SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Obx(
              //   () => Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Radio<String>(
              //         activeColor: AppColors.primaryGradinatMixColor,
              //         value: 'Male',
              //         groupValue: ownerProfileController.selectedGender.value,
              //         onChanged:
              //             (value) =>
              //                 ownerProfileController.changeGender(value!),
              //       ),
              //       Text('Male'),
              //       SizedBox(width: 20),
              //       Radio<String>(
              //         activeColor: AppColors.primaryGradinatMixColor,
              //         value: 'Female',
              //         groupValue: ownerProfileController.selectedGender.value,
              //         onChanged:
              //             (value) =>
              //                 ownerProfileController.changeGender(value!),
              //       ),
              //       Text('Female'),
              //       SizedBox(width: 20),
              //       Radio<String>(
              //         activeColor: AppColors.primaryGradinatMixColor,
              //         value: 'Other',
              //         groupValue: ownerProfileController.selectedGender.value,
              //         onChanged:
              //             (value) =>
              //                 ownerProfileController.changeGender(value!),
              //       ),
              //       Text('Other'),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     Text('Select language'),
              //     Icon(Icons.arrow_forward_ios_outlined, size: 15),
              //   ],
              // ),
              // SizedBox(
              //   height: 50,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: ownerProfileController.languages.length,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap:
              //             () => ownerProfileController.toggleSelection(index),
              //         child: Obx(() {
              //           bool isSelected = ownerProfileController.isSelected(
              //             index,
              //           );
              //           return Container(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 15,
              //               vertical: 8,
              //             ),
              //             margin: EdgeInsets.symmetric(
              //               horizontal: 8,
              //               vertical: 5,
              //             ),
              //             decoration: BoxDecoration(
              //               color:
              //                   isSelected
              //                       ? AppColors.primaryGradinatMixColor
              //                       : Colors.transparent,
              //               border: Border.all(
              //                 color:
              //                     isSelected
              //                         ? Colors.transparent
              //                         : AppColors.border,
              //               ),
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Text(
              //               ownerProfileController.languages[index],
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w500,

              //                 color:
              //                     isSelected
              //                         ? AppColors.white
              //                         : AppColors.textPrimary,
              //               ),
              //             ),
              //           );
              //         }),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(height: 10),
              // CustomTextFormField(
              //   hintText:
              //       // storeCategoryController.previousPageGridTitle == 'Expert'
              //       //     ? 'About Expert'
              //       //     : storeCategoryController.previousPageGridTitle ==
              //       //         'Rental'
              //       //     ? 'About Rental Item'
              //       //     :
              //       'About Drone',
              //   borderRadius: 10,
              //   keyboardType: TextInputType.text,
              //   controller: ownerProfileController.About,
              //   maxLines: 3,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Enter About Rental Item';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 20),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     color: AppColors.background,
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'B. Profession Details',
              //         style: GoogleFonts.montserrat(
              //           fontSize: 14,
              //           fontWeight: FontWeight.w600,
              //           color: AppColors.textPrimary,
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         'Please Select The Experties of Expert',
              //         style: GoogleFonts.montserrat(
              //           fontSize: 14,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       Obx(
              //         () => CustomDropdown<String>(
              //           hint: 'Area of Experties',
              //           items:
              //               ownerProfileController
              //                   .storeChannelList, // Keep it as List<String>
              //           selectedItem:
              //               ownerProfileController.selectedItem.value.isEmpty
              //                   ? null
              //                   : ownerProfileController.selectedItem.value,
              //           onChanged: (value) {
              //             ownerProfileController.updatedSelectedValue(
              //               value ?? '',
              //             );
              //           },
              //           itemBuilder: (item) => item, // Correct item mapping
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       CustomTextFormField(
              //         hintText: 'Other Experties',
              //         keyboardType: TextInputType.text,
              //         controller: ownerProfileController.specialization,
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please Enter Other Experties';
              //           }
              //           return null;
              //         },
              //       ),
              //       SizedBox(height: 10),

              //       Text(
              //         'Highest Qualification',
              //         style: GoogleFonts.montserrat(
              //           fontSize: 14,
              //           fontWeight: FontWeight.w600,
              //           color: AppColors.textPrimary,
              //         ),
              //       ),
              //       SizedBox(height: 10),

              //       Obx(
              //         () => CustomDropdown<String>(
              //           hint: 'Choose Highest Qualification',
              //           items:
              //               ownerProfileController
              //                   .qualification, // Keep it as List<String>
              //           selectedItem:
              //               ownerProfileController
              //                       .selectedItemQualification
              //                       .value
              //                       .isEmpty
              //                   ? null
              //                   : ownerProfileController
              //                       .selectedItemQualification
              //                       .value,
              //           onChanged: (value) {
              //             ownerProfileController
              //                 .updatedSelectedValueQualification(value ?? '');
              //           },
              //           itemBuilder: (item) => item, // Correct item mapping
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       CustomTextFormField(
              //         hintText: 'Specialization',
              //         keyboardType: TextInputType.text,
              //         controller: ownerProfileController.specialization,
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please Enter Expert Name';
              //           }
              //           return null;
              //         },
              //       ),
              //       SizedBox(height: 10),
              //       Center(
              //         child: Text(
              //           'Upload your Certificate here ',
              //           style: GoogleFonts.montserrat(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //             color: AppColors.primaryGradinatMixColor,
              //             decoration: TextDecoration.underline,
              //             decorationColor: AppColors.primaryGradinatMixColor,
              //           ),
              //         ),
              //       ),
              //       SizedBox(height: 10),

              //       GestureDetector(
              //         onTap: () {
              //           _uploadCertificateDialog(); // Show image source dialog on tap
              //         },
              //         child: Center(
              //           child: DottedBorder(
              //             color: AppColors.border,
              //             dashPattern: [6, 3],
              //             borderType: BorderType.RRect,
              //             radius: Radius.circular(10),
              //             child: Container(
              //               height: 150,
              //               width: double.infinity,
              //               padding: EdgeInsets.symmetric(horizontal: 10),
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: AppColors.white,
              //               ),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Obx(
              //                     () =>
              //                         ownerProfileController
              //                                     .selectedImage
              //                                     .value !=
              //                                 null
              //                             ? Image.file(
              //                               ownerProfileController
              //                                   .selectedImage
              //                                   .value!,
              //                               height: 100,
              //                               width: double.infinity,
              //                               fit: BoxFit.cover,
              //                             )
              //                             : SvgPicture.asset(
              //                               'assets/icons/uploadicon.svg',
              //                             ),
              //                   ),
              //                   Text(
              //                     'Upload Certificate',
              //                     style: GoogleFonts.montserrat(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //                   ),
              //                   SizedBox(height: 10),
              //                   Text(
              //                     'JPEG, PNG less than 5MB',
              //                     style: GoogleFonts.montserrat(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                       color: AppColors.textSecondary,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(height: 10),

              //       Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: AppColors.border),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(6.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     'Certificate Must show:',
              //                     style: GoogleFonts.montserrat(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(height: 10),
              //                   Row(
              //                     children: [
              //                       Icon(Icons.check, size: 20),
              //                       Text('  Registration number'),
              //                     ],
              //                   ),
              //                   SizedBox(height: 5),
              //                   Row(
              //                     children: [
              //                       Icon(Icons.check, size: 20),
              //                       Text('  Certificate number'),
              //                     ],
              //                   ),
              //                   SizedBox(height: 5),
              //                   Row(
              //                     children: [
              //                       Icon(Icons.check, size: 20),
              //                       Text('  Experties Area'),
              //                     ],
              //                   ),
              //                   SizedBox(height: 5),
              //                 ],
              //               ),
              //               SizedBox(width: 10),
              //               GestureDetector(
              //                 onTap: () {
              //                   Get.defaultDialog(
              //                     title: 'Sample',
              //                     titlePadding: EdgeInsets.only(
              //                       top: 10,
              //                       left: 10,
              //                       right: 10,
              //                       bottom: 0,
              //                     ),
              //                     titleStyle: GoogleFonts.montserrat(
              //                       fontWeight: FontWeight.w500,
              //                       fontSize: 18,
              //                       color: AppColors.primaryGradinatMixColor,
              //                     ),
              //                     content: Image.asset(
              //                       'assets/images/certificate Sample Image.jpg',
              //                       fit: BoxFit.cover,
              //                     ),
              //                   );
              //                 },
              //                 child: Container(
              //                   height: 120,
              //                   padding: EdgeInsets.symmetric(
              //                     horizontal: 15,
              //                     vertical: 10,
              //                   ),
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     border: Border.all(color: AppColors.border),
              //                     image: DecorationImage(
              //                       image: AssetImage(
              //                         'assets/images/certificate Sample Image.jpg',
              //                       ),
              //                       fit: BoxFit.fill,
              //                       opacity: 0.2,
              //                     ),
              //                   ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Icon(Icons.visibility),
              //                       Text(
              //                         'View Sample',
              //                         style: GoogleFonts.montserrat(
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'B. Owner’s KYC:',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Documents uploaded for KYC',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Aadhar Card-',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [1, 3],
                            color: AppColors.border,
                            radius: Radius.circular(10),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: Center(
                                child: Container(
                                  height: 15,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color: AppColors.containerShadowColor,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0.7,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'For KYC',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Brijesh Aadhar Front.jpeg',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkBlue,
                                  ),
                                  softWrap:
                                      true, // Allows text to wrap into multiple lines
                                  overflow:
                                      TextOverflow
                                          .ellipsis, // Ellipsis on overflow
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'ID: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2011 03XX XXXX',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Uploaded on: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2024, March 24',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColors.background,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: AppColors.lightskyBlue,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Approved',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightskyBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [1, 3],
                            color: AppColors.border,
                            radius: Radius.circular(10),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: Center(
                                child: Container(
                                  height: 15,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color: AppColors.containerShadowColor,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0.7,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'For KYC',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Wrap the Column with Expanded to avoid overflow
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Brijesh Aadhar Front.jpeg',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkBlue,
                                  ),
                                  softWrap:
                                      true, // Allows text to wrap into multiple lines
                                  overflow:
                                      TextOverflow
                                          .ellipsis, // Ellipsis on overflow
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'ID: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2011 03XX XXXX',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Uploaded on: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2024, March 24',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColors.background,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: AppColors.lightskyBlue,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Approved',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightskyBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'PAN Card-',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [1, 3],
                            color: AppColors.border,
                            radius: Radius.circular(10),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: Center(
                                child: Container(
                                  height: 15,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color: AppColors.containerShadowColor,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0.7,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'For KYC',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pan.jpeg',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'ID: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '2011 03XX XXXX',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Uploaded on: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '2024,March 24',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkBlue,
                                        textStyle: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xffFFF1DE),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Color(0xffFECB82),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Approved',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Voter ID-',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [1, 3],
                            color: AppColors.border,
                            radius: Radius.circular(10),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: Center(
                                child: Container(
                                  height: 15,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color: AppColors.containerShadowColor,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0.7,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'For KYC',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Wrapping the Column with Expanded to prevent overflow
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VoterID.png',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'ID: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2011 03XX XXXX',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Uploaded on: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2024, March 24',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color(0xffFFDFE0),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Color(0xffFD4044),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Document Declined',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFD4044),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Passport',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [1, 3],
                            color: AppColors.border,
                            radius: Radius.circular(10),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: Center(
                                child: Container(
                                  height: 15,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color: AppColors.border,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0.7,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'For KYC',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'passport.pdf',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'ID: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '2011 03XX XXXX',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Uploaded on: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '2024,March 24',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkBlue,
                                        textStyle: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.background,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.error,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Document Expired',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffE67070),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomGradientButton(
                      text: '+ Add New Document',
                      onPressed: () {},
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: GradientText(
                        text: 'Contact for help!',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primarySecondGradiant,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'C. Owner’s photos:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Take or upload your clear photo in front also inside of your store or shop.',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomUploadImageWidget(
                                  padding: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                  ),
                                  label: 'Upload Outside Image',
                                  size: 'JPEG, PNG less than 10MB',
                                  onImagePicked: (file) {
                                    if (file != null) {
                                      print('Picked Image ${file}');
                                    }
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Front of the Store or shop',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                CustomUploadImageWidget(
                                  padding: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                  ),
                                  height: 100,
                                  width: 100,
                                  label: 'Upload Inside Image',
                                  size: 'JPEG, PNG less than 10MB',
                                  onImagePicked: (file) {
                                    if (file != null) {
                                      print('Picked Image ${file}');
                                    }
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Inside of the Store or Shop',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'D. Owner’s Signature:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Add a signature to sign over legal documents',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        color: AppColors.border,
                        dashPattern: [2, 3],
                        radius: Radius.circular(15),
                        child: Container(
                          // height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Digital Signature",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "PNG less than 3MB",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GradientText(
                                      text: 'Upload',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryFirstGradiant,
                                          AppColors.primarySecondGradiant,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(color: AppColors.border),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: AppColors.background,
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "mysignature.png",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff4C83EA),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Delete",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.check_circle,
                                      color: Color(0xff4C83EA),
                                    ),
                                  ],
                                ),
                              ],
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
      ),
    );
  }
}

void _uploadCertificateDialog() {
  final OwnerProfileController ownerProfileController = Get.put(
    OwnerProfileController(),
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
                  ownerProfileController.pickImage(ImageSource.camera);
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
                  ownerProfileController.pickImage(ImageSource.gallery);
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
