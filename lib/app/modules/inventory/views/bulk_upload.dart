import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/bulk_upload_controller.dart';
import 'package:farmitra/app/modules/inventory/views/product_export.dart';
import 'package:farmitra/app/modules/inventory/views/review_upload_file.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BulkUpload extends StatelessWidget {
  BulkUpload({super.key});
  final BulkUploadController bulkUploadController = Get.put(
    BulkUploadController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: VendorAppBar(
        title: "Bulk Upload",
        actions: [
          // paddingZero,
          buildActionButton(Icons.message_sharp),
          buildActionButton(Icons.notifications_outlined),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Download Excel Template',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ProductExport());
                    },
                    child: Text(
                      'See Instructions',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () {},
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.green),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      text: 'With Data',
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomGradientButton(
                      height: 37,
                      text: 'Without Data',
                      onPressed: () {},
                      borderRadius: 5,
                      gradientColors: [AppColors.green, AppColors.green],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              RichText(
                textWidthBasis: TextWidthBasis.longestLine,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Last Updated: ',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextSpan(
                      text: ' Today 08:44 Pm',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Obx(() {
                        return bulkUploadController.isCheckedShow.value
                            ? Checkbox(
                              activeColor: AppColors.primaryGradinatMixColor,
                              value:
                                  index <
                                          bulkUploadController
                                              .checkBoxList
                                              .length
                                      ? bulkUploadController
                                          .checkBoxList[index]
                                          .value
                                      : false,
                              onChanged: (value) {
                                if (index <
                                    bulkUploadController.checkBoxList.length) {
                                  bulkUploadController.toggleCheckbox(
                                    index,
                                    value!,
                                  );
                                }
                              },
                            )
                            : SizedBox.shrink();
                      }),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ReviewUploadFile());
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                      color: AppColors.border,
                                      offset: Offset(0, 1),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/Excel_icon.svg',
                                      fit: BoxFit.fill,
                                      height: 50,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Shopping item sheet.xls',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
                                          SizedBox(height: 5),
                                          Text(
                                            '8 Sep 2021 08:44 PM',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        bulkUploadController.isCheckedShow
                                            .toggle();
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColors.green,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 5,
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
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Obx(
        () => Container(
          height: bulkUploadController.selectedFile.value == null ? 100 : 200,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: AppColors.background),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              DottedBorder(
                color: AppColors.border,
                radius: Radius.circular(15),
                borderType: BorderType.RRect,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add New Excel Sheet',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'XLSX less than 15MB',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              bulkUploadController
                                  .pickFile(); // ✅ Correct method call
                            },
                            child: GradientText(
                              text: 'Browse Here',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryFirstGradiant,
                                  AppColors.primarySecondGradiant,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (bulkUploadController.selectedFile.value != null)
                        Column(
                          children: [
                             Divider(
                              color: AppColors.containerShadowColor,
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink[50],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.task_outlined),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bulkUploadController
                                              .selectedFile
                                              .value
                                              ?.path
                                              ?.split('/')
                                              ?.last ??
                                          '',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        bulkUploadController
                                            .deleteFile(); // ✅ Correct function usage
                                      },
                                      child: Text(
                                        'Delete',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.skyBlue,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            CustomGradientButton(
                              text: 'Upload Excel File',
                              onPressed: () {
                                bulkUploadController.deleteFile();
                              },
                            ),
                          ],
                        ),
                      // Text("data")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildActionButton(IconData icon) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.white),
    ),
    child: IconButton(
      onPressed: () {},
      icon: Icon(icon, color: AppColors.white),
    ),
  );
}

// Show dialog to choose file
void showFilePickerDialog(BuildContext context) {
  final BulkUploadController bulkUploadController = Get.put(
    BulkUploadController(),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Choose a file"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tap below to select a file to upload"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await bulkUploadController.pickFile();
                Navigator.of(
                  context,
                ).pop(); // Close the dialog after file is picked
              },
              child: Text("Pick File"),
            ),
          ],
        ),
      );
    },
  );
}
