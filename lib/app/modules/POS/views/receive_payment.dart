import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/receive_payment_controller.dart';
import 'package:farmitra/app/modules/POS/views/bill_details.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
class ReceivePayment extends StatelessWidget {
  ReceivePayment({super.key});
  final ReceivePaymentController receivePaymentController = Get.put(
    ReceivePaymentController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5F4E8),
      appBar: AppBar(
        backgroundColor: Color(0xffE5F4E8),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹ 1,000.00',
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Subham Rawat \nTo Pay in cash',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 100),
            Text(
              'Facing Problem? Try...',
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
              itemCount: receivePaymentController.procedure.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, 
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
                        receivePaymentController.procedure[index],
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
      bottomNavigationBar: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustomOutlinedButton(
                      onPressed: () {
                        Get.to(() => BillDetails());
                      },
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.green),
                      ),
                      text: 'Cash Collected',
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 150,
            top: 15,
            child: CircleAvatar(
              backgroundColor: AppColors.green,
              radius: 35,
              child: Icon(Icons.check, color: AppColors.white, size: 35),
            ),
          ),
        ],
      ),
    );
  }
}
