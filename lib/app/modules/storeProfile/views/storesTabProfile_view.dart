import 'dart:ffi';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/models/store_select_model/store_select_model.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/modules/registration/views/store_details_view.dart';
import 'package:farmitra/app/modules/registration/views/store_selecte_module_view.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/storeTabProfile_controller.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/store_profile_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class StoresTabProfileView extends GetView {
  StoresTabProfileView({super.key});
  final StoresTabProfileController storesTabProfileController = Get.put(
    StoresTabProfileController(),
  );
  final StoreProfileController storeProfileController = Get.find();

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${box.read('user_role')} Information',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        buildExpertInformationBottomSheet(context),
                        isScrollControlled: true,
                        backgroundColor: AppColors.white,
                      );
                    },
                    child: Text(
                      'Edit',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.skyBlue,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.skyBlue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Obx(() {
                final detailsList = storesTabProfileController.detailsList;

                if (detailsList.isEmpty) {
                  return Center(
                    child: Text(
                      "No details available",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: detailsList.length,
                  itemBuilder: (context, index) {
                    final item = detailsList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100, // fixed width for labels
                            child: Text(
                              item['details'] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              (item['data'] ?? '').toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: true,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
              SizedBox(height: 10),
              Obx(
                () =>
                    storesTabProfileController.userRole.value == 'Expert'
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: AppColors.border),
                            Text(
                              'About Expert',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              storeProfileController
                                      .userDetails
                                      .value
                                      ?.data
                                      ?.about ??
                                  '',
                              textAlign: TextAlign.left,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        )
                        : SizedBox.shrink(),
              ),

              Divider(color: AppColors.border),

              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView.builder(
                    itemCount:
                        storesTabProfileController.moduleDetailsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item =
                          storesTabProfileController.moduleDetailsList[index];
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.01,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(item['color']),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical:
                                MediaQuery.of(context).size.height * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GradientSvgIcon(
                                icon: Icon(item['icon'] ?? 'N/A'),
                                size: MediaQuery.of(context).size.width * 0.06,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                item['title'] ?? 'N/A',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                item['subtitle'] ?? 'N/A',
                                style: GoogleFonts.montserrat(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/Edit.svg',
                                    height:
                                        MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    'Edit',
                                    style: GoogleFonts.montserrat(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.025,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(StoreDetailsView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+ Add Another Module ?',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.skyBlue,
                        // decoration: TextDecoration.underline,d
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10),
              Divider(color: AppColors.border),
              // SizedBox(height: 10),
              Text(
                '${storesTabProfileController.userRole.value} KYC:',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Documents uploaded for ${storesTabProfileController.userRole.value} KYC',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                itemCount: storesTabProfileController.documentlist.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var documents =
                      storesTabProfileController.documentlist[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Shop & E-License Certificate-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppColors.border,
                              child: Container(
                                height: 100,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/kyc/pan-card.webp',
                                    ),
                                    fit: BoxFit.fill,
                                    opacity: 0.2,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    color: AppColors.background,
                                    child: SizedBox(
                                      height: 15,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [Text('For KYC')],
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
                                  '${documents['file_name']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${documents['id_number']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${documents['uploaded_on']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColors.lightBlue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: AppColors.lightskyBlue,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Approved ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.lightskyBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: CustomGradientButton(
                  width: 180,
                  text: '+ Add New Document',
                  onPressed: () {
                    Get.to(() => RentalKyc());
                  },
                ),
              ),

              // SizedBox(height: 20),
              // Center(
              //   child: GradientText(
              //     text: 'Contact for help!',
              //     style: GoogleFonts.montserrat(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: [
              //         AppColors.primaryFirstGradiant,
              //         AppColors.primarySecondGradiant,
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20),
              // Divider(color: AppColors.border),
              // SizedBox(height: 20),
              // Text(
              //   'Store photos:',
              //   style: GoogleFonts.montserrat(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Text(
              //   'Take or upload clear photos of your store or shop.',
              //   style: GoogleFonts.montserrat(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //     color: AppColors.textSecondary,
              //   ),
              // ),
              // SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             storesTabProfileController.pickImage('inside');
              //           },
              //           child: Obx(() {
              //             return DottedBorder(
              //               dashPattern: [2.5, 5],
              //               borderType: BorderType.RRect,
              //               color: AppColors.border,
              //               radius: Radius.circular(10),
              //               child: Container(
              //                 height: 120,
              //                 width: 135,
              //                 child:
              //                     storesTabProfileController
              //                             .inside
              //                             .value
              //                             .isEmpty
              //                         ? Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             SvgPicture.asset(
              //                               'assets/svgs/uploadicon.svg',
              //                             ),
              //                             SizedBox(height: 5),
              //                             Text(
              //                               'Upload Logo',
              //                               style: GoogleFonts.montserrat(
              //                                 fontSize: 12,
              //                                 fontWeight: FontWeight.w600,
              //                               ),
              //                             ),
              //                             SizedBox(height: 5),
              //                             Text(
              //                               textAlign: TextAlign.center,
              //                               'JPEG,PNG,less then 3 MB',
              //                               style: GoogleFonts.montserrat(
              //                                 fontSize: 12,
              //                                 fontWeight: FontWeight.w400,
              //                               ),
              //                             ),
              //                           ],
              //                         )
              //                         : ClipRRect(
              //                           borderRadius: BorderRadius.circular(10),
              //                           child: Image.file(
              //                             File(
              //                               storesTabProfileController
              //                                   .inside
              //                                   .value,
              //                             ),
              //                           ),
              //                         ),
              //               ),
              //             );
              //           }),
              //         ),
              //         SizedBox(height: 10),
              //         Text(
              //           'Inside',
              //           style: GoogleFonts.montserrat(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //             color: AppColors.textSecondary,
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(width: 15),
              //     Column(
              //       children: [
              //         Obx(() {
              //           return GestureDetector(
              //             onTap: () {
              //               storesTabProfileController.pickImage('outside');
              //             },
              //             child: DottedBorder(
              //               dashPattern: [2.5, 5],
              //               borderType: BorderType.RRect,
              //               color: AppColors.border,
              //               radius: Radius.circular(10),
              //               child: Container(
              //                 height: 120,
              //                 width: 135,
              //                 child:
              //                     storesTabProfileController
              //                             .outside
              //                             .value
              //                             .isEmpty
              //                         ? Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             SvgPicture.asset(
              //                               'assets/svgs/uploadicon.svg',
              //                             ),
              //                             SizedBox(height: 5),
              //                             Text(
              //                               'Upload Logo',
              //                               style: GoogleFonts.montserrat(
              //                                 fontSize: 12,
              //                                 fontWeight: FontWeight.w600,
              //                               ),
              //                             ),
              //                             SizedBox(height: 5),
              //                             Text(
              //                               textAlign: TextAlign.center,
              //                               'JPEG,PNG,less then 5 MB',
              //                               style: GoogleFonts.montserrat(
              //                                 fontSize: 12,
              //                                 fontWeight: FontWeight.w400,
              //                               ),
              //                             ),
              //                           ],
              //                         )
              //                         : ClipRRect(
              //                           borderRadius: BorderRadius.circular(10),
              //                           child: Image.file(
              //                             File(
              //                               storesTabProfileController
              //                                   .outside
              //                                   .value,
              //                             ),
              //                           ),
              //                         ),
              //               ),
              //             ),
              //           );
              //         }),
              //         SizedBox(height: 10),
              //         Text(
              //           'Outside',
              //           style: GoogleFonts.montserrat(
              //             fontWeight: FontWeight.w600,
              //             color: AppColors.textSecondary,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // will be shown in Vendor
              box.read('user_role') == 'Vendor'
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Divider(color: AppColors.border),
                      SizedBox(height: 10),
                      Text(
                        'Delivery Details:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Free Delivery Radius(Km)',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomTextFormField(
                        hintText: "Radius",
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        controller: storesTabProfileController.redius,
                        validator: (p0) {},
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: "Minimum Order Value(MOV)(₹)",
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        controller: storesTabProfileController.minOrderValue,
                        validator: (p0) {},
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Define Scheduled Delivery Charges:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Set delivery charges based on the distance range(Kms)',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'No Range Available ',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: '+ Add Now',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Support Express Delivery',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Additional ₹40 will be charged',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          // ✅ Only reactive part wrapped with Obx
                          Obx(
                            () => Switch(
                              value:
                                  storesTabProfileController
                                      .isAddtionalCharges
                                      .value,
                              onChanged: (value) {
                                storesTabProfileController
                                    .isAddtionalCharges
                                    .value = value;
                              },
                              activeTrackColor:
                                  AppColors.primaryGradinatMixColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(color: AppColors.border),
                      SizedBox(height: 20),
                      Text(
                        'Delivery Slots:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Available for service for this duration',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'No Slots Available  ',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: '+ Add Slots',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: AppColors.border),
                      SizedBox(height: 20),
                      Text(
                        'Gift / Wrapping Price:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your delivery charges for send product as gift.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text('Amount:'),
                      CustomTextFormField(
                        hintText: '₹',
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        controller: storesTabProfileController.giftWrapAmmount,
                        validator: (p0) {},
                      ),
                      SizedBox(height: 15),
                      SizedBox(height: 10),
                      Divider(color: AppColors.border),
                      SizedBox(height: 20),
                      Text(
                        'Serving Hours:',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Available for service for this duration',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Start Time:'),
                                CustomTextFormField(
                                  hintText: '00:00 Hrs',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  controller:
                                      storesTabProfileController.startTime,
                                  validator: (p0) {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('End Time:'),
                                CustomTextFormField(
                                  hintText: '00:00 Hrs',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  controller:
                                      storesTabProfileController.endTime,
                                  validator: (p0) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              // Divider(color: AppColors.border),
              // SizedBox(height: 35),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Account Status'),
                        SizedBox(height: 5),
                        GradientText(
                          text: "FF FREEMIUM",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffFD4044),
                              Color(0xff800002),
                              Color(0xff08094B),
                            ],
                          ),
                        ),
                        Text(
                          'Valid till August 20, 2024',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: CustomGradientButton(
                        text: "Go Premium",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildImageWidget(String imagePath) {
  File imageFile = File(imagePath);
  if (imageFile.existsSync()) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(imageFile, fit: BoxFit.cover),
    );
  } else {
    return Center(
      child: Text(
        "Image not found",
        style: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.error,
        ),
      ),
    );
  }
}

Widget buildExpertInformationBottomSheet(context) {
  final StoresTabProfileController storesTabProfileController = Get.put(
    StoresTabProfileController(),
  );
  final StoreLocationController storeLocationController = Get.put(
    StoreLocationController(),
  );
  return Container(
    height: MediaQuery.of(context).size.height * 0.75, // fixed height
    // color: AppColors.white,
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Expert Information",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Spacer(),
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
              // SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 10),

          CustomTextFormField(
            hintText: 'Full Name',
            keyboardType: TextInputType.text,
            inputFormatters: [],
            controller: storesTabProfileController.name,
            validator: (p0) {},
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: '+91',
            keyboardType: TextInputType.number,
            inputFormatters: [],
            controller: storesTabProfileController.number,
            validator: (p0) {},
            suffixWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Text(
                'Change',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightskyBlue,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [],
            controller: storesTabProfileController.email,
            validator: (p0) {},
            suffixWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Text(
                'Change',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightskyBlue,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // CustomTextFormField(
          //   suffixIcon: Icons.location_on_sharp,
          //   onSuffixIconTap: () => Get.toNamed('/store_location'),
          //   hintText: 'Location',
          //   keyboardType: TextInputType.text,
          //   inputFormatters: [],
          //   controller: ,
          //   validator: (p0) {},
          // ),
          SizedBox(height: 10),

          CustomTextFormField(
            hintText: 'Complete Address',
            suffixIcon: Icons.location_on_sharp,
            onSuffixIconTap: () => Get.toNamed('/store_location'),

            keyboardType: TextInputType.text,
            inputFormatters: [],
            controller: storeLocationController.combinedController,
            validator: (p0) {},
          ),
          SizedBox(height: 10),

          CustomTextFormField(
            hintText: 'Landmark',
            keyboardType: TextInputType.number,
            inputFormatters: [],
            controller: storeLocationController.landmark,
            validator: (p0) {},
          ),
          SizedBox(height: 10),

          CustomTextFormField(
            hintText: 'Pin Code',
            keyboardType: TextInputType.number,
            inputFormatters: [],
            controller: storeLocationController.pincode,
            validator: (p0) {},
          ),
          SizedBox(height: 10),

          CustomTextFormField(
            hintText: 'About ',
            borderRadius: 10,
            keyboardType: TextInputType.text,
            controller: storesTabProfileController.About,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter About Expert ';
              }
              return null;
            },
          ),
          SizedBox(height: 10),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,
                  value: 'Male',
                  groupValue: storesTabProfileController.selectedGender.value,
                  onChanged:
                      (value) =>
                          storesTabProfileController.changeGender(value!),
                ),
                Text('Male'),
                SizedBox(width: 20),
                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,
                  value: 'Female',
                  groupValue: storesTabProfileController.selectedGender.value,
                  onChanged:
                      (value) =>
                          storesTabProfileController.changeGender(value!),
                ),
                Text('Female'),
                SizedBox(width: 20),
                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,
                  value: 'Other',
                  groupValue: storesTabProfileController.selectedGender.value,
                  onChanged:
                      (value) =>
                          storesTabProfileController.changeGender(value!),
                ),
                Text('Other'),
              ],
            ),
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Text('Select language'),
              Icon(Icons.arrow_forward_ios_outlined, size: 15),
            ],
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: storesTabProfileController.languages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      () => storesTabProfileController.toggleSelection(index),
                  child: Obx(() {
                    bool isSelected = storesTabProfileController.isSelected(
                      index,
                    );
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                        storesTabProfileController.languages[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color:
                              isSelected
                                  ? AppColors.white
                                  : AppColors.textPrimary,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          CustomGradientButton(text: 'Update Details', onPressed: () {}),
        ],
      ),
    ),
  );
}
