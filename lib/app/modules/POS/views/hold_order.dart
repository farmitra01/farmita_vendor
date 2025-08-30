import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/hold_order_controller.dart';
import 'package:farmitra/app/modules/POS/views/checkout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HoldOrder extends StatelessWidget {
  const HoldOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final HoldOrderController holdOrderController = Get.put(
      HoldOrderController(),
    );
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightGrey,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On-Hold Orders:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Manage Temporarily Held Orders and Proceed to\nCheckout.',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Divider(color: AppColors.border),
              SizedBox(height: 10),
              Obx(
                () => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: holdOrderController.holdOrder.length,
                  itemBuilder: (context, index) {
                    var data =
                        holdOrderController
                            .holdOrder[index]; // Access observable inside Obx
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: AppColors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['user'],
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                index == 2
                                                    ? AppColors
                                                        .primaryGradinatMixColor
                                                    : AppColors.textPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'June 24, 2024, 3:15 PM',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    if (index != 2)
                                      GestureDetector(
                                        onTap: () async {
                                          String phoneNumber =
                                              "9721854225"; // Your WhatsApp number
                                          String encodedMessage =
                                              Uri.encodeComponent(
                                                "Hello from my app",
                                              ); // Optional message

                                          // Try the direct WhatsApp protocol URL
                                          final uri = Uri.parse(
                                            'whatsapp://send?phone=$phoneNumber&text=$encodedMessage',
                                          );

                                          try {
                                            await launchUrl(
                                              uri,
                                              mode:
                                                  LaunchMode
                                                      .externalApplication,
                                            );
                                          } catch (e) {
                                            // If direct protocol fails, try the web URL as fallback
                                            try {
                                              final webUri = Uri.parse(
                                                'https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedMessage',
                                              );
                                              await launchUrl(
                                                webUri,
                                                mode:
                                                    LaunchMode
                                                        .externalNonBrowserApplication,
                                              );
                                            } catch (e) {
                                              print(
                                                'Error launching WhatsApp: $e',
                                              );
                                              Get.snackbar(
                                                'Error',
                                                'Failed to open WhatsApp. Make sure WhatsApp is installed.',
                                              );
                                            }
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'assets/svgs/whatsapp.svg',
                                          height: 20,
                                        ),
                                      ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                          'Order Details will be shared',
                                        );
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: AppColors.black,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    holdOrderController.removeOrder(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.error,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade500,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Colors.grey.shade600,
                                        ),
                                        child: Image.asset(
                                          'assets/images/brinjal.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10 items',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '₹1,567  ',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '₹2,346',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textSecondary,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => Checkout());
                                  },
                                  child: Text(
                                    'View cart',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
