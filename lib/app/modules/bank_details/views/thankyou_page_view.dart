import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankyouPageView extends GetView {
  const ThankyouPageView({super.key});
  @override
  Widget build(BuildContext context) {
    var previousPageGridTitle = Get.arguments ?? '';
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
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/thankyou.svg',
                    color: AppColors.primaryGradinatMixColor,
                  ),
                  Positioned(
                    top: 85,
                    left: 82,
                    child: Icon(
                      Icons.done_all,
                      size: 35,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Thank you for\nBecome Farmitra Expert.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'We Will shortly Notify on Your\nregistered Phone about approval profile',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: CustomGradientButton(
            text: 'Back to home',
            onPressed: () {
              Get.offAllNamed(
                '/homeBottomBarView',
                arguments: previousPageGridTitle,
              );
              // print('Argument ${previousPageGridTitle}');
            },
          ),
        ),
      ),
    );
  }
}
