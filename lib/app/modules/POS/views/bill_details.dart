import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/bill_details_controller.dart';
import 'package:farmitra/app/modules/home/views/home_bottom_bar_view.dart';
import 'package:farmitra/app/modules/home/views/home_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Ensure BillDetailsController is properly defined with reactive properties
class BillDetails extends StatelessWidget {
  const BillDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller only if it doesn't exist
    final BillDetailsController billDetailsController = Get.put(
      BillDetailsController(),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 15,
                child: Icon(Icons.arrow_back, color: AppColors.white),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Share.share('Check out my bill details!');
              },
              child: buildActionButton(Icons.share, 'Share'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 0.1,
                color: Colors.grey,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'BILL DETAILS',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SvgPicture.asset('assets/svgs/farmitra.svg', height: 75),
                const SizedBox(height: 10),
                Text(
                  '05 Apr 2024 to 04 May 2024',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: AppColors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: AppColors.black, size: 20),
                        Text(
                          ': Amit Kumar Singh',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.call, color: AppColors.black, size: 20),
                        Text(
                          ': +91 88022 04049',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.lightGrey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Title',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Amount',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Use Obx only if billDetails is reactive
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: billDetailsController.billDetails.length,
                    itemBuilder: (context, index) {
                      var data = billDetailsController.billDetails[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['title'] ?? 'N/A',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              data['amount'] ?? 'N/A',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: AppColors.black),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '₹520',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Generated on May 04, 2024 at 02:55 AM Using GooglePay UPI',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset('assets/images/seal.png', height: 100),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.print),
                      onPressed: () {
                        Get.snackbar('Print', 'Printing bill...');
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        const phoneNumber = '9721854225';
                        const message = 'Hello from my app';
                        final encodedMessage = Uri.encodeComponent(message);
                        final uri = Uri.parse(
                          'whatsapp://send?phone=$phoneNumber&text=$encodedMessage',
                        );
                        try {
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            final webUri = Uri.parse(
                              'https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedMessage',
                            );
                            await launchUrl(
                              webUri,
                              mode: LaunchMode.externalNonBrowserApplication,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to open WhatsApp. Make sure WhatsApp is installed.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/whatsapp.svg',
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: CustomGradientButton(
          icon: Icons.reply,
          text: 'Back to POS',
          onPressed: () => Get.to(HomeBottomBarView()),
        ),
      ),
    );
  }

  Widget buildActionButton(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.white),
          const SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
