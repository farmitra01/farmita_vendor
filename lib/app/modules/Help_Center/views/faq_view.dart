import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Help_Center/controllers/faq_controller.dart';
import 'package:farmitra/app/routes/app_pages.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqView extends GetView {
  FaqView({super.key});

  final FaqController faqController = Get.put(FaqController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: VendorAppBar(title: 'FAQ'),

      body: Obx(() {
        if (faqController.isLoading.value) {
          return  Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryGradinatMixColor,
            ),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Help?',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqController.faqCategoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final category = faqController.faqCategoryList[index];
                    var svglist = [
                      'assets/icons/faq_grid_icons/business.svg',
                      'assets/icons/faq_grid_icons/bank.svg',
                      'assets/icons/faq_grid_icons/kyc.svg',
                      'assets/icons/faq_grid_icons/AcVerified.svg',
                      'assets/icons/faq_grid_icons/registrantion.svg',
                      'assets/icons/faq_grid_icons/return.svg',
                      'assets/icons/faq_grid_icons/delievery.svg',
                    ];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.faq_grid_pages,
                          arguments: {'title': category},
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(svglist[index], height: 30),
                          const SizedBox(height: 10),
                          Text(
                            category.capitalize ?? "",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.border)),
                    Text('Or'),
                    Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  // color: AppColors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need More Help?',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Chat with our support team for quick assistance.',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 20),
                            GradientOutlinedButton(
                              borderRadius: BorderRadius.circular(10),
                              text: "Chat with us",
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.primaryFirstGradiant,
                                  AppColors.primarySecondGradiant,
                                ],
                              ),
                              onPressed: () {
                                Get.toNamed('/text-support');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SvgPicture.asset(
                        'assets/svgs/farmitra.svg',
                        height: 100,
                        width: double.infinity,
                        color: AppColors.secondary.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
