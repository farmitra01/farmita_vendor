import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/review_upload_file_controller.dart';
import 'package:farmitra/app/modules/inventory/views/inventory_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewUploadFile extends StatelessWidget {
  ReviewUploadFile({super.key});

  final ReviewUploadFileController reviewUploadFileController = Get.put(
    ReviewUploadFileController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review Upload File',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Check the details and confirm the import of your products.',
              overflow: TextOverflow.visible,
              softWrap: true,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            // SizedBox(height: 15,)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close, color: AppColors.error, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            const Divider(color: AppColors.border),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white,
                    boxShadow:  [
                      BoxShadow(
                        blurRadius: 1,
                        color: AppColors.containerShadowColor,
                        offset: Offset(0, 1),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/Excel_icon.svg',
                        fit: BoxFit.fill,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shopping item sheet.xls',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '10 Mb',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '8 Sep 2021 08:44 Pm',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      'NEW',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Obx(() {
                  return reviewUploadFileController.isChecked.value == true
                      ? Checkbox(
                        value: reviewUploadFileController.isAllSelected.value,
                        activeColor: AppColors.primaryGradinatMixColor,
                        onChanged: (bool? value) {
                          if (value != null) {
                            reviewUploadFileController.toggleSelectAll(value);
                          }
                        },
                      )
                      : SizedBox(width: 10);
                }),
                SizedBox(width: 5),
                RichText(
                  textWidthBasis: TextWidthBasis.longestLine,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Products ',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: ' ( Products)',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var itemCount = index;
                return Column(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        reviewUploadFileController.showCheckBox();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Obx(
                            () =>
                                reviewUploadFileController.isChecked.value ==
                                        true
                                    ? SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: Obx(() {
                                        return Checkbox(
                                          activeColor:
                                              AppColors.primaryGradinatMixColor,
                                          value:
                                              reviewUploadFileController
                                                  .productSelections[index],
                                          onChanged: (value) {
                                            if (value != null) {
                                              reviewUploadFileController
                                                  .toggleProductSelection(
                                                    index,
                                                    value,
                                                  );
                                              print('Selected item ${index}');
                                            }
                                          },
                                        );
                                      }),
                                    )
                                    : reviewUploadFileController
                                            .selectedIndex ==
                                        index
                                    ? SizedBox(
                                      height: 5,
                                      width: 10,
                                      child: Obx(
                                        () => Checkbox(
                                          activeColor:
                                              AppColors.primaryGradinatMixColor,
                                          value:
                                              reviewUploadFileController
                                                  .selectedItems[index],
                                          onChanged: (value) {
                                            reviewUploadFileController
                                                .toggleSelection(index);
                                          },
                                        ),
                                      ),
                                    )
                                    : SizedBox(),
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            'assets/images/Capsicum.png',
                            fit: BoxFit.fill,
                            height: 75,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Green Capsicum (Shimla Mirch)',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '250 g',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              RichText(
                                textWidthBasis: TextWidthBasis.longestLine,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '₹40 ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ₹50',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Obx(() {
              return CustomGradientButton(
                text:
                    reviewUploadFileController.isImport.value == false
                        ? "Import To Library"
                        : " 100% Done",
                text2:
                    reviewUploadFileController.isShowCheckBox.value == true
                        ? "${reviewUploadFileController.selectedItems}"
                        : reviewUploadFileController.isImport.value == false
                        ? "(10 product found)"
                        : null,
                onPressed: () {
                  reviewUploadFileController.isImport.value == false
                      ? Get.dialog(buildAlertBox())
                      : Get.to(InventoryView());
                },
                height: 50,
              );
            }),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: AppColors.error),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      reviewUploadFileController.isImport.value = false;
                    },
                    child: Text(
                      reviewUploadFileController.isImport.value == false
                          ? 'Delete File'
                          : "Cancel Import",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildAlertBox() {
  final ReviewUploadFileController reviewUploadFileController = Get.put(
    ReviewUploadFileController(),
  );

  return AlertDialog(
    content: SingleChildScrollView(
      // Prevent overflow issues
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prevent unnecessary height expansion
        children: [
          SvgPicture.asset(
            'assets/svgs/alert_triangel.svg',
            fit: BoxFit.contain,
            height: 50, // Set a fixed size
          ),
          SizedBox(height: 10),
          Text(
            'Confirm Products Import',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Proceed with importing 150 products from the uploaded Excel sheet?',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () {
                Get.back();
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.secondary),
              ),
              icon: Icons.close,
              iconColor: AppColors.secondary,
              text: 'Cancel',
              textStyle: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomGradientButton(
              text: 'Import',
              onPressed: () {
                reviewUploadFileController.isImport.value = true;
                Get.back();
              },
              height: 35,
            ),
          ),
        ],
      ),
    ],
  );
}
