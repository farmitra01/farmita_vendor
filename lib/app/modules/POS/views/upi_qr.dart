import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/upiQR_controller.dart';
import 'package:farmitra/app/modules/POS/views/receive_payment.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';

class UpiQr extends StatelessWidget {
  const UpiQr({super.key});

  @override
  Widget build(BuildContext context) {
    final UpiqrController upiqrController = Get.put(UpiqrController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primaryGradinatMixColor,
              child: Icon(Icons.close, color: AppColors.white),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, color: AppColors.appBarColor),
                SizedBox(width: 10),
                Text(
                  'Security Guaranteed',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBarColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Show this to your customer to scan and pay you using any mobile bank app',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '₹ 1,000.00',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            Icon(Icons.qr_code_2_sharp, size: 250, color: AppColors.black),
            SizedBox(height: 10),
            Text(
              'UPI ID: jpprovisionalstore@oksbi',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'To scan and pay',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: upiqrController.procedure.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Makes Row as small as its content
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Text(
                          '0${index + 1}.',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.appBarColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        upiqrController.procedure[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.appBarColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.all(15),
        child: CustomGradientButton(
          text: 'Payment Successfully Received',
          onPressed: () {
            Get.to(() => ReceivePayment());
          },
        ),
      ),
    );
  }
}
