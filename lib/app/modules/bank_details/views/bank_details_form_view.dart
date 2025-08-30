import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/bank_details/controllers/bank_details_form_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class BankDetailsFormView extends GetView {
  BankDetailsFormView({super.key});
  final BankDetailsFormController bankDetailsFormController = Get.put(
    BankDetailsFormController(),
  );
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bank Details:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Add bank details to receive your salary or other\npayments through the safe and secured server.',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                Divider(thickness: 1, color: AppColors.border),
                CustomTextFormField(
                  hintText: 'Bank A/C No.',
                  keyboardType: TextInputType.number,
                  controller: bankDetailsFormController.accountNo,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Bank A/C No.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'A/C Holder Name',
                  keyboardType: TextInputType.text,
                  controller: bankDetailsFormController.holderName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter A/C Holder Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Bank Name',
                  keyboardType: TextInputType.text,
                  controller: bankDetailsFormController.bankName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Bank Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Branch Name',
                  keyboardType: TextInputType.text,
                  controller: bankDetailsFormController.branchName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Branch Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'IFSC Code',
                  keyboardType: TextInputType.text,
                  controller: bankDetailsFormController.ifsc,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter IFSC Code.';
                    }
                    if (value.length != 11) {
                      return "Please Enter Valid IFSC Code";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Enter PAN Number',
                  keyboardType: TextInputType.text,
                  controller: bankDetailsFormController.pan,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter PAN Number.';
                    }
                    if (value.length != 10) {
                      return "Please Enter Valid PAN Number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Obx(
                  () => CustomDropdown<String>(
                    hint: 'Choose Bank Details',
                    items:
                        bankDetailsFormController
                            .bankDetails, // Keep it as List<String>
                    selectedItem:
                        bankDetailsFormController.selectedItem.value.isEmpty
                            ? null
                            : bankDetailsFormController.selectedItem.value,
                    onChanged: (value) {
                      bankDetailsFormController.updatedSelectedValue(
                        value ?? '',
                      );
                    },
                    itemBuilder: (item) => item, // Correct item mapping
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
                                bankDetailsFormController.selectedImage.value !=
                                        null
                                    ? Image.file(
                                      bankDetailsFormController
                                          .selectedImage
                                          .value!,
                                      height: 100,
                                      width: 125,
                                      fit: BoxFit.fill,
                                    )
                                    : SvgPicture.asset(
                                      'assets/icons/uploadicon.svg',
                                    ),
                          ),
                          Text(
                            'Upload Selected Document',
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
                  'Upload your Selected Document here (1:1)',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGradinatMixColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 175,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: bankDetailsFormController.isChecked.value,
                      activeColor: AppColors.primaryGradinatMixColor,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        bankDetailsFormController.toggleCheckBox(value);
                      },
                    ),
                  ),
                  Text(
                    'I confirm my submission for this document.',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomGradientButton(
                text: 'Submit',
                onPressed: () async {
                  if (formkey.currentState!.validate() &&
                      bankDetailsFormController.isChecked.value &&
                      bankDetailsFormController.validateDropdown()) {
                    final success =
                        await bankDetailsFormController.submitBankDetails();
                    if (success) {
                      Get.toNamed('/bank-details');
                    }
                  } else {
                    Get.snackbar(
                      'Notice',
                      'Please fill all required fields and check the agreement box',
                      backgroundColor: AppColors.error,
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
  final BankDetailsFormController bankDetailsFormController = Get.put(
    BankDetailsFormController(),
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
                  bankDetailsFormController.pickImage(ImageSource.camera);
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
                  bankDetailsFormController.pickImage(ImageSource.gallery);
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
