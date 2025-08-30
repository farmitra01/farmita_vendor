import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/views/payment.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';

class PosWarning extends StatelessWidget {
  const PosWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEF6D9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFEF6D9),
        actions: [
          GestureDetector(
            onTap: () {
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              ();
            },
            child: Icon(Icons.close, color: AppColors.error),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you Sure ?',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffF9C000),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "You don't want to associate this order with any customer.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffF9C000),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "If customer not selected it will directly saved with the order id, you can view all of your orders in order history.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: Icon(
                  Icons.warning_rounded,
                  color: Color(0xffF9C000),
                  size: 180,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: CustomOutlinedButton(
          text: 'Proceed Without Customer ',
          textStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xffF9C000),
          ),
          onPressed: () {
            Get.to(() => Payment());
          },
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Color(0xffF9C000)),
          ),
        ),
      ),
    );
  }
}
