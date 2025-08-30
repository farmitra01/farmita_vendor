import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/my_subscription/views/racharge_plan_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import '../controllers/my_subscription_controller.dart';

class MySubscriptionView extends GetView<MySubscriptionController> {
  MySubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(MySubscriptionController());

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text(
          'My Business Plan',
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Obx(
            () => Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColors.border,
                    offset: Offset(0, 1),
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Row(
                children:
                    controller.tabs.asMap().entries.map((entry) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(entry.key),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color:
                                  controller.tabIndex.value == entry.key
                                      ? AppColors.primaryGradinatMixColor
                                      : AppColors.lightGrey,
                            ),
                            child: Center(
                              child: Text(
                                entry.value,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color:
                                      controller.tabIndex.value == entry.key
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () =>
                  controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.errorMessage.value.isNotEmpty
                      ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            controller.errorMessage.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      : buildPlan(controller.selectedType.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: Obx(() {
          String buttonText;
          bool isButtonEnabled = controller.plans.isNotEmpty;
          if (!controller.trial.value) {
            buttonText = 'Start 1-Month Free Trial';
          } else if (controller.trial.value) {
            buttonText = 'Trial Period Expires in 15 Days';
          } else if (controller.renew.value) {
            buttonText = 'Renew/Upgrade Plan';
          } else {
            buttonText = 'Unknown Status';
          }
          return CustomGradientButton(
            text: buttonText,
            onPressed: () {},
            // isButtonEnabled
            //     ? () {
            //         if (!controller.trial.value) {
            //           controller.trial.value = true;
            //         } else if (controller.trial.value) {
            //           controller.renew.value = true;
            //           controller.trial.value = false;
            //           Get.to(() => RechargePlan());
            //         } else if (controller.renew.value) {
            //           controller.trial.value = false;
            //           Get.to(() => RechargePlan());
            //         }
            //       }
            //     : null, // Disable button if no plans
          );
        }),
      ),
    );
  }

  Widget buildPlan(String planType) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Active Plan Summary
              Obx(() {
                if (controller.plans.isEmpty) return SizedBox();
                final selectedPlan =
                    controller.plans[0]; // Always use 0th index
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              planType,
                              style: GoogleFonts.montserrat(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            if (selectedPlan.isActive)
                              Card(
                                elevation: 0,
                                color: AppColors.lightGrey,
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: AppColors.textPrimary,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Active',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Next Billing Date: \n30/05/2025',
                          style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              }),

              // Features of selected plan
              Obx(() {
                if (controller.plans.isEmpty ||
                    controller.plans[0].features.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      'No features available.',
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.plans[0].features.length,
                  itemBuilder: (context, index) {
                    final feature = controller.plans[0].features[index];
                    return Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.primaryGradinatMixColor,
                            size: 16.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
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

              SizedBox(height: 10.h),

              // Plan Cards
              SizedBox(
                height: 160.h,
                child: Obx(() {
                  if (controller.plans.isEmpty) {
                    return Center(
                      child: Text(
                        'No plans available for $planType',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.plans.length,
                    itemBuilder: (context, index) {
                      final plan = controller.plans[index];
                      final original = double.tryParse(plan.discount) ?? 0;
                      final discounted = double.tryParse(plan.amount) ?? 0;
                      final total = original + discounted;
                      final percentSaved =
                          total > 0 ? ((original / total) * 100).round() : 0;

                      return SizedBox(
                        width: 180.w,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () => controller.selectPlan(0),
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 15.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 8.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              plan.planName,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textPrimary,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Obx(
                                            () => Radio<int>(
                                              activeColor:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                              value: index,
                                              groupValue:
                                                  controller
                                                      .selectedIndex
                                                      .value,
                                              onChanged: (_) {
                                                controller.selectPlan(0);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        '₹${discounted.toStringAsFixed(0)}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      if (original > 0) ...[
                                        SizedBox(height: 5.h),
                                        Text(
                                          '₹${total.toStringAsFixed(0)}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textSecondary,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                      SizedBox(height: 5.h),
                                      Text(
                                        '${plan.durationDays} days',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (controller.selectedIndex.value == index &&
                                percentSaved > 0)
                              Positioned(
                                top: 5.h,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: AppColors.green,
                                    ),
                                    child: Text(
                                      'Saving $percentSaved%',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
