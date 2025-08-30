import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Advertisement/controllers/create_new_ads_controller.dart';
import 'package:farmitra/app/modules/POS/views/payment.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewAdsView extends StatelessWidget {
  const CreateNewAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNewAdsController createNewAdsController = Get.put(
      CreateNewAdsController(),
    );
    return Scaffold(
      appBar: VendorAppBar(title: 'Create New Ads'),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Title',
                keyboardType: TextInputType.text,
                controller: createNewAdsController.title,
                validator: (p0) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: 'Description',

                    borderRadius: 10,
                    keyboardType: TextInputType.text,
                    controller: createNewAdsController.description,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter About Rental Item';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'URL',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: 'Paste URL',

                    // borderRadius: 10,
                    keyboardType: TextInputType.text,
                    controller: createNewAdsController.description,
                    // maxLines:
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter About Rental Item';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category ',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Obx(
                    () => CustomDropdown<String>(
                      hint: 'Category',
                      items:
                          createNewAdsController
                              .couponTypes, // Keep it as List<String>
                      selectedItem:
                          createNewAdsController.selectedItem.value.isEmpty
                              ? null
                              : createNewAdsController.selectedItem.value,
                      onChanged: (value) {
                        createNewAdsController.updatedSelectedValue(
                          value ?? '',
                        );
                      },
                      itemBuilder: (item) => item, // Correct item mapping
                    ),
                  ),
                ],
              ),

              // SizedBox(height: 10),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            onTap:
                                () => createNewAdsController.pickDate(
                                  isStartDate: true,
                                  context: context,
                                ),
                            decoration: InputDecoration(
                              hintText: 'Select Start Date',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: createNewAdsController.startDate.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            onTap:
                                () => createNewAdsController.pickDate(
                                  isStartDate: false,
                                  context: context,
                                ),
                            decoration: InputDecoration(
                              hintText: 'Select End Date',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: createNewAdsController.endDate.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Video',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  createNewAdsController.pickMediaFiles(); // Open file picker
                },
                child: DottedBorder(
                  color: AppColors.border,
                  dashPattern: [6, 3],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Obx(
                      () =>
                          createNewAdsController.selectedFiles.isEmpty
                              ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/uploadicon.svg',
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Upload Image or Video',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'JPEG, PNG, MP4, MOV (Max 5MB)',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              )
                              : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    createNewAdsController.selectedFiles.map((
                                      file,
                                    ) {
                                      final isVideo =
                                          file.path.endsWith('.mp4') ||
                                          file.path.endsWith('.mov');
                                      return Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child:
                                            isVideo
                                                ? Center(
                                                  child: Icon(
                                                    Icons.videocam,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                                : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                    file,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                      );
                                    }).toList(),
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: CustomGradientButton(
                text: 'Reset',
                onPressed: () {},
                gradientColors: [
                  AppColors.primaryGradinatMixColor,
                  AppColors.primaryGradinatMixColor,
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomGradientButton(
                text: 'Create Ads & Pay',
                onPressed: () {
                  Get.to(Payment());
                },
                gradientColors: [
                  AppColors.primaryGradinatMixColor,
                  AppColors.primaryGradinatMixColor,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
