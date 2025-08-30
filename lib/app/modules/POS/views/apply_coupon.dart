import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/apply_coupon_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';

class ApplyCoupon extends StatelessWidget {
  const ApplyCoupon({super.key});
  @override
  Widget build(BuildContext context) {
    final ApplyCouponController applyCouponController = Get.put(
      ApplyCouponController(),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apply Coupon',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Your cart: ₹520',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primaryGradinatMixColor,
              child: Icon(Icons.close, color: AppColors.white),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: CustomTextFormField(
                  hintText: 'Enter Coupon Code',
                  keyboardType: TextInputType.text,
                  controller: applyCouponController.couponCode,
                  borderRadius: 10,
                  validator:
                      (value) =>
                          value?.isEmpty ?? true ? 'Enter coupon code' : null,
                  suffixWidget: GestureDetector(
                    onTap: () => applyCouponController.applyCoupon(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Text(
                        'Apply',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Available Offers',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            // margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.border,

                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              backgroundColor: Colors.transparent,
                              shape: Border.all(color: Colors.transparent),
                              iconColor: AppColors.primaryGradinatMixColor,
                              title: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '60%\nOFF',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              AppColors.primaryGradinatMixColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.border,
                                    height: 100,
                                    width: 1.5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'TRYNEW',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Shopping for the first time coupon',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 30,
                                            width: 100,
                                            child: CustomGradientButton(
                                              text: 'APPLY',
                                              borderRadius: 5,
                                              onPressed: () {
                                                applyCouponController
                                                    .couponCode
                                                    .text = 'TRYNEW';
                                                applyCouponController
                                                    .applyCoupon();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Coming Soon...',
                                      style: GoogleFonts.montserrat(
                                        color:
                                            AppColors.primaryGradinatMixColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                color: AppColors.green,
                              ),
                              child: Text(
                                'NEW',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  );
                },
              ),
              SizedBox(height: 10),
              Text(
                'More Offers',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            // margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.containerShadowColor,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              backgroundColor: Colors.transparent,
                              shape: Border.all(color: Colors.transparent),
                              iconColor: AppColors.primaryGradinatMixColor,
                              title: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '60%\nOFF',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              AppColors.primaryGradinatMixColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.border,
                                    height: 100,
                                    width: 1.5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'TRYNEW',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Shopping for the first time coupon',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 30,
                                            width: 100,
                                            child: CustomGradientButton(
                                              text: 'APPLY',
                                              borderRadius: 5,
                                              onPressed: () {
                                                applyCouponController
                                                    .couponCode
                                                    .text = 'TRYNEW';
                                                applyCouponController
                                                    .applyCoupon();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Coming Soon...',
                                      style: GoogleFonts.montserrat(
                                        color:
                                            AppColors.primaryGradinatMixColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                color: AppColors.green,
                              ),
                              child: Text(
                                'NEW',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
