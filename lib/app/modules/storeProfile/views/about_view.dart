import 'dart:ffi';
import 'dart:ui';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/about_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutView extends GetView {
  AboutView({super.key});
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final AboutController aboutController = Get.put(AboutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                // Obx(
                //   () =>
                //       aboutController.isTextVisible.value
                //           ? Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Obx(() {
                //                 if (aboutController.isExpanded.value) {
                //                   return Text(
                //                     aboutController.aboutStore.value.text,
                //                     style: GoogleFonts.montserrat(
                //                       fontSize: 14,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                   );
                //                 } else {
                //                   return Text(
                //                     maxLines: 4,
                //                     overflow: TextOverflow.ellipsis,
                //                     aboutController.aboutStore.value.text,
                //                     style: GoogleFonts.montserrat(
                //                       fontSize: 14,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                   );
                //                 }
                //                 ;
                //               }),
                //               GestureDetector(
                //                 onTap: () {
                //                   aboutController.toggleTExt();
                //                 },
                //                 child: Text(
                //                   aboutController.isExpanded.isFalse
                //                       ? "Read More"
                //                       : "Read less",
                //                   style: GoogleFonts.montserrat(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w500,
                //                     color: AppColors.lightskyBlue,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           )
                //           : CustomTextFormField(
                //             borderRadius: 10,
                //             maxLines: 5,
                //             hintText: 'Enter Details Here...',
                //             keyboardType: TextInputType.text,
                //             controller: aboutController.aboutStore.value,
                //             validator: (value) {
                //               if (value!.isEmpty) {
                //                 return '';
                //               }
                //               return null;
                //             },
                //           ),
                // ),
                SizedBox(height: 15),
                Text(
                  'Amenities :-',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Obx(
                  () =>
                      aboutController.isTextVisible.isFalse
                          ? Column(
                            children: [
                              SizedBox(height: 15),
                              Text(
                                'Selected',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                          : SizedBox(),
                ),
                SizedBox(
                  height: 225,
                  child: Obx(
                    () =>
                        aboutController.selectedAmenities.isEmpty
                            ? Center(
                              child: Text(
                                'No Amenities Selected.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                            : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 1,
                                  ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  aboutController.selectedAmenities.length,
                              itemBuilder: (context, index) {
                                final selectedItem =
                                    aboutController.selectedAmenities[index];
                                return Row(
                                  children: [
                                    SizedBox(width: 5),
                                    GradientSvgIcon(
                                      icon: Icon(selectedItem.icon),
                                      size: 20,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryFirstGradiant,
                                          AppColors.primarySecondGradiant,
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      selectedItem.text,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    Obx(
                                      () =>
                                          aboutController.isTextVisible.isFalse
                                              ? Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {
                                                      aboutController
                                                          .selectedAmenities
                                                          .removeAt(index);
                                                    },
                                                    child: GradientSvgIcon(
                                                      icon: Icon(
                                                        Icons.cancel_outlined,
                                                      ),
                                                      size: 16,
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .primaryFirstGradiant,
                                                          AppColors
                                                              .primarySecondGradiant,
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                              : SizedBox(),
                                    ),
                                  ],
                                );
                              },
                            ),
                  ),
                ),
                SizedBox(height: 15),
                Obx(
                  () =>
                      aboutController.isTextVisible.isFalse
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 225,
                                child: Obx(
                                  () => GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 3 / 1,
                                        ),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: aboutController.amenities.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          aboutController.amenities[index];
                                      return GestureDetector(
                                        onTap: () {
                                          aboutController.addAmenitiesToGrid(
                                            item,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_outlined,
                                              color: AppColors.secondary,
                                            ),
                                            SizedBox(width: 5),
                                            GradientSvgIcon(
                                              icon: Icon(
                                                aboutController
                                                    .amenities[index]
                                                    .icon,
                                              ),
                                              size: 20,
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors
                                                      .primaryFirstGradiant,
                                                  AppColors
                                                      .primarySecondGradiant,
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              aboutController
                                                  .amenities[index]
                                                  .text,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                          : SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomGradientButton(
          text: 'Update About',
          onPressed: () {
            aboutController.showText();
            print('Tapped');

            if (formkey.currentState!.validate()) {
              Get.snackbar(
                backgroundColor: AppColors.darkBlue,
                colorText: AppColors.white,
                "Notice",
                'Profile Updated',
              );
            } else {
              Get.snackbar(
                backgroundColor: AppColors.darkBlue,
                colorText: AppColors.white,
                "Notice",
                'Select Amenities from Available and Enter details',
              );
            }
          },
        ),
      ),
    );
  }
}
