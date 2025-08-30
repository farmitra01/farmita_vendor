import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/login/controllers/add_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddView extends GetView {
  AddView({super.key});
  final AddController addController = Get.put(AddController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(showTitle: true, title: 'App Language'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Language',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            // Text(
            //   'Please select a preferred language to be used within the app. You can change this setting anytime.',
            //   style: GoogleFonts.montserrat(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.textSecondary,
            //   ),
            // ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 0.0, // No spacing between columns
                  mainAxisSpacing: 0.0, // No spacing between rows
                  childAspectRatio:
                      125 /
                      60, // Adjusts the aspect ratio of each grid item to match the width and height
                ),
                itemCount:
                    addController
                        .languages
                        .length, // Number of items in the grid
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Center(
                            child:
                            // index == 0
                            // ?
                            Text(
                              addController.languages[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ), // Empty container for index 0
                            // :
                          ),
                        ),
                      ),
                      // if (index == 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                          child:
                              index == 0
                                  ? Icon(
                                    Icons.check,
                                    color: AppColors.white,
                                    size: 20,
                                  )
                                  : Icon(
                                    Icons.lock,
                                    size: 20,

                                    color: AppColors.white.withOpacity(0.8),
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            CustomGradientButton(
              text: 'Continue',
              onPressed: () {
                Get.toNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
