import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliverySupportView extends GetView {
  const DeliverySupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: GestureDetector(
            onTap: () {
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              ();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back, color: AppColors.white),
                  SizedBox(width: 5),
                  Text(
                    'Delievery Support',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'DeliverySupportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
