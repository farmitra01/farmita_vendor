import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/kyc_documents/controllers/owners_details.controller.dart';
import 'package:farmitra/app/modules/kyc_documents/views/owner_upload_doc.dart';
import 'package:farmitra/app/modules/kyc_documents/views/rental_kyc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnersDetails extends StatelessWidget {
  const OwnersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnersDetailscontroller ownersDetailscontroller = Get.put(
      OwnersDetailscontroller(),
    );

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
                itemCount: ownersDetailscontroller.documentsList.length,
                itemBuilder: (context, index) {
                  final docName = ownersDetailscontroller.documentsList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => OwnerUploadDoc(), arguments: docName);
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
                          ownersDetailscontroller.documentsList[index],
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
