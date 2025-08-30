import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/bank_details/controllers/upi_details_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final UpiDetailsController upiDetailsController = Get.put(
  UpiDetailsController(),
);

class UpiDetailsView extends GetView {
  UpiDetailsView({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPI Details:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Add QR or UPI ID to accept salary online.',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onTap: () {
                Get.back();
                ();
              },
              child: Icon(Icons.close, color: AppColors.error),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                Divider(thickness: 1, color: AppColors.border),
                SizedBox(height: 15),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Document Must show:',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 20,
                                  color: AppColors.textSecondary,
                                ),
                                Text(
                                  '  Clear image of QR with\n  Black squares',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 20,
                                  color: AppColors.textSecondary,
                                ),
                                Text(
                                  '   Arranged in a square grid\n   on a white  background',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        DottedBorder(
                          color: AppColors.border,
                          dashPattern: [6, 3],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                title: '',
                                titlePadding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  bottom: 0,
                                ),
                                titleStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                                content: Image.asset(
                                  'assets/images/bank/QR_code.webp',
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            child: Container(
                              height: 120,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bank/QR_code.webp',
                                  ),
                                  fit: BoxFit.fill,
                                  opacity: 0.2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.visibility),
                                  Text(
                                    'View Sample',
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _showImagePickerDialog(); // Show image source dialog on tap
                  },
                  child: DottedBorder(
                    color: AppColors.border,
                    dashPattern: [6, 3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () =>
                                upiDetailsController.selectedImage.value != null
                                    ? Image.file(
                                      upiDetailsController.selectedImage.value!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                    : SvgPicture.asset(
                                      'assets/icons/uploadicon.svg',
                                    ),
                          ),
                          Text(
                            'Upload QR',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'JPEG, PNG less than 5MB',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Upload your QR here (1:1)',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGradinatMixColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryGradinatMixColor,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: AppColors.border),
                    ),
                    Text(' or '),
                    Expanded(
                      child: Divider(thickness: 0.5, color: AppColors.border),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Customer Name',
                  keyboardType: TextInputType.text,
                  controller: upiDetailsController.customerName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Customer Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: "Enter UPI ID",
                  keyboardType: TextInputType.text,
                  controller: upiDetailsController.upiId,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter UPI ID.';
                    }
                    return null;
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(12)],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: upiDetailsController.isChecked.value,
                      // side: BorderSide(
                      //   color: upiDetailsController.isChecked.value == false
                      //       ? Colors.red
                      //       : Colors.white,
                      // ),
                      activeColor: AppColors.primaryGradinatMixColor,
                      checkColor: AppColors.white,
                      onChanged: (value) {
                        upiDetailsController.toggleCheckBox(value);
                      },
                    ),
                  ),
                  Text(
                    'I confirm my submission for this document.',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomGradientButton(
                text: 'Validate',
                onPressed: () async {
                  if (formkey.currentState!.validate() &&
                      upiDetailsController.isChecked.value == true) {
                    final int? upiableId = GetStorage().read('user_id');
                    // final List<dynamic> roles =
                    //     GetStorage().read('user_type') ?? [];

                    String upiableType = 'Vendor';
                    // if (roles.contains('Vendor')) {
                    //   upiableType = 'Vendor';
                    // } else if (roles.contains('Expert')) {
                    //   upiableType = 'Expert';
                    // }

                    if (upiableId != null && upiableType.isNotEmpty) {
                      final success = await upiDetailsController
                          .submitUpiDetails(
                            upiableId: upiableId,
                            upiableType: upiableType,
                          );

                      if (success) {
                        Get.toNamed('/bank-details');
                      }
                    } else {
                      Get.snackbar(
                        'Error',
                        'Invalid user_id or user_type.',
                        backgroundColor: AppColors.error,
                        colorText: AppColors.white,
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Notice",
                      "All Text Field & Check box are required.",
                      backgroundColor: AppColors.primaryGradinatMixColor,
                      colorText: AppColors.white,
                    );
                  }
                },
              ),

              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/help-center');
                },
                child: Text(
                  'Contact for help!',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

void _showImagePickerDialog() {
  final UpiDetailsController upiDetailsController = Get.put(
    UpiDetailsController(),
  );
  showDialog(
    context: Get.context!, // Since you're using GetX
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Select Image:-',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryGradinatMixColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // To avoid the dialog being too large
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If you need to add additional content here
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close dialog
                  upiDetailsController.pickImage(ImageSource.camera);
                },
                child: Text(
                  'Camera',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close dialog
                  upiDetailsController.pickImage(ImageSource.gallery);
                },
                child: Text(
                  'Gallery',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
