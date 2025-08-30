import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/controllers/select_document_controller.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:farmitra/app/modules/registration/controllers/store_details_form_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectDocumentView extends GetView {
  SelectDocumentView({super.key});
  final SelectDocumentController selectDocumentController = Get.put(
    SelectDocumentController(),
  );
  final StoreDetailsFormController storeDetailsFormController = Get.put(
    StoreDetailsFormController(),
  );
  // var categoryName = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // print('Category Name : $categoryName');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 1/2 Select Any Document:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Documents required for complete KYC',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Get.back();
              Get.to(() => RentalKyc());
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryGradinatMixColor,
                child: Icon(Icons.close, color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Divider(thickness: 1.5, color: AppColors.border),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount:
                    storeDetailsFormController.categoryName == 'Expert'
                        ? selectDocumentController.qualificationsList.length
                        : selectDocumentController.documentsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String docName;
                      if (storeDetailsFormController.categoryName == 'Expert') {
                        docName =
                            selectDocumentController.qualificationsList[index];
                      } else {
                        docName = selectDocumentController.documentsList[index];
                      }
                      Get.toNamed('/kyc_upload_document', arguments: docName);
                      print('Selected value = $docName');
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Text(
                          storeDetailsFormController.categoryName == 'Expert'
                              ? selectDocumentController
                                  .qualificationsList[index]
                              : selectDocumentController.documentsList[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
