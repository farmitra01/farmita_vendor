import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Advertisement/views/ads_details_view.dart';
import 'package:farmitra/app/modules/Advertisement/views/create_new_ads_view.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/advertisement_controller.dart';

class AdvertisementView extends GetView<AdvertisementController> {
  const AdvertisementView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdvertisementController controller = Get.put(
      AdvertisementController(),
    );
    return Scaffold(
      appBar: VendorAppBar(title: 'Advertisement'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// REACTIVE HORIZONTAL LIST
            SizedBox(
              height: 50,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.adTypes.length,
                  itemBuilder: (context, index) {
                    bool isSelected =
                        controller.selectedAdTypeIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        controller.selectAdType(index);
                      },
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color:
                                isSelected
                                    ? AppColors.primaryGradinatMixColor
                                    : Colors.grey.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        color:
                            isSelected
                                ? AppColors.primaryGradinatMixColor.withOpacity(
                                  0.1,
                                )
                                : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: Center(
                            child: Text(
                              '${controller.adTypes[index]['type']} ${controller.adTypes[index]['count']}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    isSelected
                                        ? AppColors.primaryGradinatMixColor
                                        : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.green.withOpacity(0.2),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Ads ID #1000003',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Card(
                                    elevation: 0,
                                    color: AppColors.green.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Expired',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  SizedBox(width: 10),
                                  Obx(
                                    () => Switch(
                                      value: controller.isSwitched.value,
                                      activeColor:
                                          AppColors.primaryGradinatMixColor,
                                      trackOutlineWidth: WidgetStatePropertyAll(
                                        0,
                                      ),
                                      onChanged: (value) {
                                        controller.toggleSwitch(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Video Promotion',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ads Placed: 31 May 2025',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              'Duration: 01 June 2025 - 01 Dec 2025',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: AppColors.green,
                          child: IconButton(
                            onPressed: () {
                              Get.to(() => AdsDetailsView());
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          Get.to(() => CreateNewAdsView());
        },
        child: CircleAvatar(
          radius: 35,
          backgroundColor: AppColors.primaryGradinatMixColor,
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
