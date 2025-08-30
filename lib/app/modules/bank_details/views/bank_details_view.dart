import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/bank_details_controller.dart';

class BankDetailsView extends GetView<BankDetailsController> {
  const BankDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    var previousPageGridTitle = Get.arguments;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bank Details-',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please add your Payment receiving modes.',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/upi_details');
                      },
                      child: Column(
                        children: [
                          DottedBorder(
                            dashPattern: [6, 3],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            color: AppColors.border,
                            child: Container(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 40,
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.qr_code),
                                    SizedBox(height: 10),
                                    Text(
                                      'Add QR Code',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Upload QR',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  AppColors.primaryGradinatMixColor,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/bank_details_form');
                          },
                          child: DottedBorder(
                            dashPattern: [6, 3],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            color: AppColors.border,
                            child: Container(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 40,
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/registration_stepper_icons/bank.svg',
                                      height: 25,
                                      color: AppColors.black,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Add Bank Account',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Add Bank Details',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryGradinatMixColor,
                            color: AppColors.primaryGradinatMixColor,
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
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensures Column takes only required space
          children: [
            CustomGradientButton(
              text: 'Save & Submit',
              onPressed: () {
                Get.toNamed('/thankyou_page', arguments: previousPageGridTitle);
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Handle the tap action properly (e.g., navigate or show a snackbar)
                print("Skip for now tapped!");
              },
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/thankyou_page',
                    arguments: previousPageGridTitle,
                  );
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
            ),
          ],
        ),
      ),
    );
  }
}
