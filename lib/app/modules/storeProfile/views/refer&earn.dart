import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/refer&earnController.dart';
import 'package:farmitra/app/utils/global_widgets/dottedBorderContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ReferEarnView extends GetView<ReferEarnController> {
  ReferEarnView({super.key});
  final ReferEarnController controller = Get.put(ReferEarnController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGradinatMixColor.withOpacity(0.5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryGradinatMixColor.withOpacity(0.0),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Refer your friends  ",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.shareReferralWithImage();
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  // borderRadius: BorderRadius.circular(20),
                ),
                child: Lottie.asset('assets/json/refer_earn-2.json'),
              ),
              SizedBox(height: 15),
              Text(
                "100 Loyalty Points",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Your friend gets 100 Points on sign up.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 15),

              // Referral Code Section with Dotted Border
              DottedBorderContainer(referralCode: "ABCDG123"),
              Container(),
              SizedBox(height: 8),
              Text(
                "Share your Referral Code via",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              // Share Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _buildShareButton(
                  //   color: Colors.blue,
                  //   icon: Icon(Icons.telegram, color: Colors.white),
                  //   text: "Telegram",
                  //   onTap: () {
                  //     // Handle Telegram sharing
                  //   },
                  // ),
                  // SizedBox(width: 10),
                  // _buildShareButton(
                  //   color: Colors.blueAccent,
                  //   icon: Icon(Icons.facebook, color: Colors.white),
                  //   text: "Facebook",
                  //   onTap: () {
                  //     // Handle Facebook sharing
                  //   },
                  // ),
                  SizedBox(width: 10),
                  _buildShareButton(
                    color: Colors.white,
                    icon: SvgPicture.asset(
                      'assets/svgs/whatsapp.svg',
                      height: 20,
                      width: 20,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                    text: "Invite Friends",
                    onTap: () async {
                      await controller.shareReferralWithImage();
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Frequently Asked Questions Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      _buildFAQItem(
                        title: "What is Refer and Earn Program?",
                        description:
                            "Refer your friends to the app and earn rewards.app and earn rewards.",
                      ),
                      _buildFAQItem(
                        title: "How it works?",
                        description:
                            "Share your referral code. Once your friend signs up, you earn rewards.",
                      ),
                      _buildFAQItem(
                        title: "Where can I use these LoyaltyPoints?",
                        description:
                            "You can redeem LoyaltyPoints for discounts or offers.",
                      ),
                      _buildFAQItem(
                        title: "How it works?",
                        description:
                            "Share your referral code. Once your friend signs up, you earn rewards.",
                      ),
                      _buildFAQItem(
                        title: "Where can I use these LoyaltyPoints?",
                        description:
                            "You can redeem LoyaltyPoints for discounts or offers.",
                      ),
                      _buildFAQItem(
                        title: "How it works?",
                        description:
                            "Share your referral code. Once your friend signs up, you earn rewards.",
                      ),
                      _buildFAQItem(
                        title: "Where can I use these LoyaltyPoints?",
                        description:
                            "You can redeem LoyaltyPoints for discounts or offers.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Share Button Widget
  Widget _buildShareButton({
    required Color color,
    required Widget icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: Row(
            children: [
              Text(
                text,
                style: GoogleFonts.montserrat(
                  color: AppColors.primaryGradinatMixColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Container(child: icon),
            ],
          ),
        ),
      ),
    );
  }

  // FAQ Item Widget
  Widget _buildFAQItem({required String title, required String description}) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 20, left: 18),
            child: Text(
              description,
              style: GoogleFonts.montserrat(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
